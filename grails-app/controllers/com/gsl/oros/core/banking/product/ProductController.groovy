package com.gsl.oros.core.banking.product

import com.gsl.cbs.contraints.enums.CalculatedAmount
import com.gsl.cbs.contraints.enums.CircleName
import com.gsl.cbs.contraints.enums.RateType
import com.gsl.oros.core.banking.product.savings.SavingsCloseFee
import com.gsl.oros.core.banking.product.savings.SavingsEntryFee
import com.gsl.oros.core.banking.product.savings.SavingsManagementFee
import com.gsl.oros.core.banking.product.savings.SavingsProduct
import com.gsl.oros.core.banking.product.savings.SavingsInterest
import com.gsl.oros.core.banking.product.savings.SavingsProductClientType
import com.gsl.oros.core.banking.product.savings.SavingsReopenFee
import com.gsl.oros.core.banking.product.savings.SavingsTransaction
import com.gsl.oros.core.banking.product.savings.SavingsTransactionFee
import com.gsl.oros.core.banking.settings.BankSetup
import com.gsl.oros.core.banking.settings.ClientCategory
import com.gsl.oros.core.banking.settings.Currencys
import grails.converters.JSON
import sun.management.counter.perf.PerfByteArrayCounter

import java.sql.Array

class ProductController {

    def index() {
        render(view: '/coreBanking/settings/product/savings/index')
    }

    def showVoucher() {

        render(view: '/coreBanking/settings/product/showVoucher')
    }

    def createProduct(){
        def startTime = System.nanoTime()
        def currencyList = Currencys.findAll();
        def clientCategoryList = ClientCategory.findAll();
        def circle = CircleName;
        def rateType = RateType;
        def CalAmount = CalculatedAmount;

        render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
        model: [decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2, template: 'mainParameters',
                currency: currencyList, clientCategory: clientCategoryList, circleName: circle, rateType: rateType, calculatedAmountType: CalAmount])
        def endTime = System.nanoTime()
        def diff = (endTime-startTime)/1000000000
        println("Total time taken for getting request mapping for role right access: ${diff} s")
    }

    def saveMain(ProductCommand productCommand) {
        //println(params);
        def currencyList = Currencys.findAll();
        def clientCategoryList = ClientCategory.findAll();
        def circle = CircleName;
        def rateType = RateType;
        def calAmount = CalculatedAmount;

        if (productCommand.hasErrors()) {
            render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                    model: [savingsProduct: productCommand, template: ProductUtility.templateList[params.int('templateNo')],
                            decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,
                            currency: currencyList, clientCategory: clientCategoryList, circleName: circle, rateType: rateType,
                            calculatedAmountType: calAmount, productId: productCommand.id])
            return
        }

        //update product
        if(params.productId){
            SavingsProduct productEdit;
            SavingsProduct productSaveEdit;
            SavingsInterest interestEdit;
            SavingsInterest interestSaveEdit;

            productEdit = SavingsProduct.get(productCommand.productId);
            if(!productEdit){
                render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                        model: [savingsProduct: productCommand, template: ProductUtility.templateList[params.int('templateNo')],
                                decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,
                                currency: currencyList, clientCategory: clientCategoryList, circleName: circle, rateType: rateType,
                                calculatedAmountType: calAmount, productId: productCommand.id])
                return;
            }
            productEdit.properties = productCommand.properties;

            if(!productEdit.validate()){
                render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                        model: [savingsProduct: productCommand, template: ProductUtility.templateList[params.int('templateNo')],
                                decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,
                                currency: currencyList, clientCategory: clientCategoryList, circleName: circle, rateType: rateType,
                                calculatedAmountType: calAmount, productId: productCommand.id])
                return;
            }
            productSaveEdit = productEdit.save(flush: true);
            if(!productSaveEdit){
                render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                        model: [savingsProduct: productCommand, template: ProductUtility.templateList[params.int('templateNo')],
                                decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,
                                currency: currencyList, clientCategory: clientCategoryList, circleName: circle, rateType: rateType,
                                calculatedAmountType: calAmount, productId: productCommand.id])
                return
            }

            def savedInterest = [];
            def queryInterest = SavingsInterest.where {productId == productCommand.productId};
            queryInterest.deleteAll();

            if(params.startAmount){
                if(params.startAmount.class.isArray()){
                    List tempStartAmount = params.startAmount
                    List tempEndAmount = params.endAmount
                    List tempCircleName = params.circleName
                    List tempRateType = params.rateType
                    List tempRate = params.rate
                    List tempAmountBasedOnName = params.amountBasedOnName

                    for (int i = 0; i < tempStartAmount.size(); i++){
                        SavingsInterest savingsInterest = new SavingsInterest(
                                productId:productCommand.productId,
                                startAmount:tempStartAmount[i],
                                endAmount:tempEndAmount[i],
                                circleId:tempCircleName[i],
                                rateType:tempRateType[i],
                                rate:tempRate[i],
                                calculatedAmountType: tempAmountBasedOnName[i]
                        )
                        SavingsInterest savingsInterest1 = savingsInterest.save(flush: true);
                        savedInterest.add(savingsInterest1);
                    }
                }else{
                    SavingsInterest savingsInterest = new SavingsInterest(
                            productId:productCommand.productId,
                            startAmount:params.startAmount,
                            endAmount:params.endAmount,
                            circleId:params.circleName,
                            rateType:params.rateType,
                            rate:params.rate,
                            calculatedAmountType: params.amountBasedOnName
                    )
                    SavingsInterest savingsInterest1  = savingsInterest.save(flush: true);
                    savedInterest.add(savingsInterest1);
                }
            }

            render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                    model: [savingsProduct: productSaveEdit, template: ProductUtility.templateList[params.int('templateNo') + 1], savingsInterest: savedInterest,
                            decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,
                            currency: currencyList, clientCategory: clientCategoryList, circleName: circle, rateType: rateType,
                            calculatedAmountType: calAmount, productId: productSaveEdit.id])
            return
        }
        //end update product

        SavingsProduct savingsProduct = new SavingsProduct(productCommand.properties)
        SavingsProduct savedProduct = savingsProduct.save(flush: true);
        def savedInterest = [];

        if(params.startAmount){
            if(params.startAmount.class.isArray()){
                List tempStartAmount = params.startAmount
                List tempEndAmount = params.endAmount
                List tempCircleName = params.circleName
                List tempRateType = params.rateType
                List tempRate = params.rate
                List tempAmountBasedOnName = params.amountBasedOnName
                //def savedInterest = [];

                for (int i = 0; i < tempStartAmount.size(); i++){
                    SavingsInterest savingsInterest = new SavingsInterest(
                            productId:savedProduct.id,
                            startAmount:tempStartAmount[i],
                            endAmount:tempEndAmount[i],
                            circleId:tempCircleName[i],
                            rateType:tempRateType[i],
                            rate:tempRate[i],
                            calculatedAmountType: tempAmountBasedOnName[i]
                    )
                    SavingsInterest savingsInterest1 = savingsInterest.save(flush: true);
                    savedInterest.add(savingsInterest1);
                }
            }else{
                //def savedInterest;
                SavingsInterest savingsInterest = new SavingsInterest(
                        productId:savedProduct.id,
                        startAmount:params.startAmount,
                        endAmount:params.endAmount,
                        circleId:params.circleName,
                        rateType:params.rateType,
                        rate:params.rate,
                        calculatedAmountType: params.amountBasedOnName
                )
                SavingsInterest savingsInterest1  = savingsInterest.save(flush: true);
                savedInterest.add(savingsInterest1);
            }
        }


        render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
               model: [savingsProduct: savedProduct, template: ProductUtility.templateList[params.int('templateNo') + 1], savingsInterest: savedInterest,
               decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,
               currency: currencyList, clientCategory: clientCategoryList, circleName: circle, rateType: rateType,
               calculatedAmountType: calAmount, productId: savedProduct.id])
    }

    def saveTran(TransactionFeeCommand transactionFee){
        //println(params);
        def productId = params.productId;

        def cashDepositMin = params.minCashTransaction ? params.minCashTransaction.replaceAll(',', '') : 0.00;
        def cashDepositMax = params.maxCashTransaction ? params.maxCashTransaction.replaceAll(',', '') : 0.00;
        def cashWithdrawMin = params.minCashWithdrw ? params.minCashWithdrw.replaceAll(',', '') : 0.00;
        def cashWithdrawMax = params.maxCashWithdrw ? params.maxCashWithdrw.replaceAll(',', '') : 0.00;
        def cashTransferMin = params.minCashTransfer ? params.minCashTransfer.replaceAll(',', '') : 0.00;
        def cashTransferMax = params.maxCashTransfer ? params.maxCashTransfer.replaceAll(',', '') : 0.00;

        def chequeDepositMin = params.minChequeTransaction ? params.minChequeTransaction.replaceAll(',', '') : 0.00;
        def chequeDepositMax = params.maxChequeTransaction ? params.maxChequeTransaction.replaceAll(',', '') : 0.00;
        def chequeWithdrawMin = params.minChequeWithdrw ? params.minChequeWithdrw.replaceAll(',', '') : 0.00;
        def chequeWithdrawMax = params.maxChequeWithdrw ? params.maxChequeWithdrw.replaceAll(',', '') : 0.00;
        def chequeTransferMin = params.minChequeTransfer ? params.minChequeTransfer.replaceAll(',', '') : 0.00;
        def chequeTransferMax = params.minChequeTransfer ? params.minChequeTransfer.replaceAll(',', '') : 0.00;

        def cardDepositMin = params.minCardTransaction ? params.minCardTransaction.replaceAll(',', '') : 0.00;
        def cardDepositMax = params.maxCardTransaction ? params.maxCardTransaction.replaceAll(',', '') : 0.00;
        def cardWithdrawMin = params.minCardWithdrw ? params.minCardWithdrw.replaceAll(',', '') : 0.00;
        def cardWithdrawMax = params.maxCardWithdrw ? params.maxCardWithdrw.replaceAll(',', '') : 0.00;
        def cardTransferMin = params.minCardTransfer ? params.minCardTransfer.replaceAll(',', '') : 0.00;
        def cardTransferMax = params.maxCardTransfer ? params.maxCardTransfer.replaceAll(',', '') : 0.00;

        //////////     //////////
        //edit cash,card,cheque//
        //////////     //////////
        if(params.transactionCashId || params.transactionChequeId || params.transactionCardId){
            SavingsTransaction savingsTransactionEditCash;
            SavingsTransaction savingsTransactionGetCash;
            savingsTransactionEditCash = new SavingsTransaction(
                                            depositMin: cashDepositMin,
                                            depositMax: cashDepositMax,
                                            withdrawMin: cashWithdrawMin,
                                            withdrawMax: cashWithdrawMax,
                                            transferMin: cashTransferMin,
                                            transferMax: cashTransferMax,
                                            typeId: 1,
                                            productId: productId
                                        );

            savingsTransactionGetCash = SavingsTransaction.get(params.transactionCashId);
            savingsTransactionGetCash.properties = savingsTransactionEditCash.properties;
            //println(savingsTransactionGetCash.properties);
            savingsTransactionGetCash.save(flush: true);

            SavingsTransaction savingsTransactionEditCheque;
            SavingsTransaction savingsTransactionGetCheque;
            savingsTransactionEditCheque = new SavingsTransaction(
                                                depositMin: chequeDepositMin,
                                                depositMax: chequeDepositMax,
                                                withdrawMin: chequeWithdrawMin,
                                                withdrawMax: chequeWithdrawMax,
                                                transferMin: chequeTransferMin,
                                                transferMax: chequeTransferMax,
                                                typeId: 2,
                                                productId: productId
                                            );

            savingsTransactionGetCheque = SavingsTransaction.get(params.transactionChequeId);
            savingsTransactionGetCheque.properties = savingsTransactionEditCheque.properties;
            //println(savingsTransactionGetCash.properties);
            savingsTransactionGetCheque.save(flush: true);

            SavingsTransaction savingsTransactionEditCard;
            SavingsTransaction savingsTransactionGetCard;
            savingsTransactionEditCard = new SavingsTransaction(
                                                depositMin: chequeDepositMin,
                                                depositMax: chequeDepositMax,
                                                withdrawMin: chequeWithdrawMin,
                                                withdrawMax: chequeWithdrawMax,
                                                transferMin: chequeTransferMin,
                                                transferMax: chequeTransferMax,
                                                typeId: 3,
                                                productId: productId
                                            );

            savingsTransactionGetCard = SavingsTransaction.get(params.transactionCardId);
            savingsTransactionGetCard.properties = savingsTransactionEditCard.properties;
            //println(savingsTransactionGetCash.properties);
            savingsTransactionGetCard.save(flush: true);

            def queryCashTable = SavingsTransactionFee.where {transactionId == savingsTransactionGetCash.id}
            queryCashTable.deleteAll();

            def savedTransactionCashDepositFeeEdit = [];
            def savedTransactionCashWithdrawFeeEdit = [];
            def savedTransactionCashTransferFeeEdit = [];

            //cash deposit table
            if(params.cashStart){
                if(params.cashStart.class.isArray()){
                    List tempCashStart = params.cashStart
                    List tempCashEnd = params.cashEnd
                    List tempCashRateType = params.cashRateType
                    List tempCashRate = params.cashRate

                    for (int i = 0; i < tempCashStart.size(); i++){
                        SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCash.id,
                                startAmount:tempCashStart[i],
                                endAmount:tempCashEnd[i],
                                rateType:tempCashRateType[i],
                                rate:tempCashRate[i],
                                type: 1
                        )
                        SavingsTransactionFee savingsTransactionFee1 = savingsTransactionFee.save(flush: true);
                        savedTransactionCashDepositFeeEdit.add(savingsTransactionFee1);
                    }
                }else{
                    //def savedInterest;
                    SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCash.id,
                            startAmount:params.cashStart,
                            endAmount:params.cashEnd,
                            rateType:params.cashRateType,
                            rate:params.cashRate,
                            type: 1
                    )
                    SavingsTransactionFee savingsTransactionFee1  = savingsTransactionFee.save(flush: true);
                    savedTransactionCashDepositFeeEdit.add(savingsTransactionFee1);
                }
            }
            //end cash deposit table
            //cash withdraw table
            if(params.withdrwlStartAm){
                if(params.withdrwlStartAm.class.isArray()){
                    List tempwithdrwlStartAm = params.withdrwlStartAm
                    List tempwithdrwlEndAm = params.withdrwlEndAm
                    List tempwithdrwlRateType = params.withdrwlRateType
                    List tempwithdrwlRate = params.withdrwlRate

                    for (int i = 0; i < tempwithdrwlStartAm.size(); i++){
                        SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCash.id,
                                startAmount:tempwithdrwlStartAm[i],
                                endAmount:tempwithdrwlEndAm[i],
                                rateType:tempwithdrwlRateType[i],
                                rate:tempwithdrwlRate[i],
                                type: 2
                        )
                        SavingsTransactionFee savingsTransactionFee1 = savingsTransactionFee.save(flush: true);
                        savedTransactionCashWithdrawFeeEdit.add(savingsTransactionFee1);
                    }
                }else{
                    SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCash.id,
                            startAmount:params.withdrwlStartAm,
                            endAmount:params.withdrwlEndAm,
                            rateType:params.withdrwlRateType,
                            rate:params.withdrwlRate,
                            type: 2
                    )
                    SavingsTransactionFee savingsTransactionFee1  = savingsTransactionFee.save(flush: true);
                    savedTransactionCashWithdrawFeeEdit.add(savingsTransactionFee1);
                }
            }
            //end cash withdraw table
            //cash transfer table
            if(params.transferStartAmount){
                if(params.transferStartAmount.class.isArray()){
                    List tempTransferStartAmount = params.transferStartAmount
                    List tempTransferEndAmount = params.transferEndAmount
                    List tempTransferRateType = params.transferRateType
                    List tempTransferRate = params.transferRate

                    for (int i = 0; i < tempTransferStartAmount.size(); i++){
                        SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCash.id,
                                startAmount:tempTransferStartAmount[i],
                                endAmount:tempTransferEndAmount[i],
                                rateType:tempTransferRateType[i],
                                rate:tempTransferRate[i],
                                type: 3
                        )
                        SavingsTransactionFee savingsTransactionFee1 = savingsTransactionFee.save(flush: true);
                        savedTransactionCashTransferFeeEdit.add(savingsTransactionFee1);
                    }
                }else{
                    SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCash.id,
                            startAmount:params.transferStartAmount,
                            endAmount:params.transferEndAmount,
                            rateType:params.transferRateType,
                            rate:params.transferRate,
                            type: 3
                    )
                    SavingsTransactionFee savingsTransactionFee1  = savingsTransactionFee.save(flush: true);
                    savedTransactionCashTransferFeeEdit.add(savingsTransactionFee1);
                }
            }
            //end cash transfer table

            def queryCardTable = SavingsTransactionFee.where {transactionId == savingsTransactionGetCard.id}
            queryCardTable.deleteAll();

            def savedTransactionCardDepositFeeEdit = [];
            def savedTransactionCardWithdrawFeeEdit = [];
            def savedTransactionCardTransferFeeEdit = [];

            //card deposit table
            if(params.cardStart){
                if(params.cardStart.class.isArray()){
                    List tempCardStart = params.cardStart
                    List tempCardEnd = params.cardEnd
                    List tempCardRateType = params.cardRateType
                    List tempCardRate = params.cardRate

                    for (int i = 0; i < tempCardStart.size(); i++){
                        SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCard.id,
                                startAmount:tempCardStart[i],
                                endAmount:tempCardEnd[i],
                                rateType:tempCardRateType[i],
                                rate:tempCardRate[i],
                                type: 1
                        )
                        SavingsTransactionFee savingsCardTransactionFee1 = savingsCardTransactionFee.save(flush: true);
                        savedTransactionCardDepositFeeEdit.add(savingsCardTransactionFee1);
                    }
                }else{
                    //def savedInterest;
                    SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCard.id,
                            startAmount:params.cardStart,
                            endAmount:params.cardEnd,
                            rateType:params.cardRateType,
                            rate:params.cardRate,
                            type: 1
                    )
                    SavingsTransactionFee savingsCardTransactionFee1  = savingsCardTransactionFee.save(flush: true);
                    savedTransactionCardDepositFeeEdit.add(savingsCardTransactionFee1);
                }
            }
            //end card deposit table
            //card withdraw table
            if(params.cardWithdrwlStartAm){
                if(params.cardWithdrwlStartAm.class.isArray()){
                    List tempCardWithdrwlStartAm = params.cardWithdrwlStartAm
                    List tempCardWithdrwlEndAm = params.cardWithdrwlEndAm
                    List tempCardWithdrwlRateType = params.cardWithdrwlRateType
                    List tempCardWithdrwlRate = params.cardWithdrwlRate

                    for (int i = 0; i < tempCardWithdrwlStartAm.size(); i++){
                        SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCard.id,
                                startAmount:tempCardWithdrwlStartAm[i],
                                endAmount:tempCardWithdrwlEndAm[i],
                                rateType:tempCardWithdrwlRateType[i],
                                rate:tempCardWithdrwlRate[i],
                                type: 2
                        )
                        SavingsTransactionFee savingsCardTransactionFee1 = savingsCardTransactionFee.save(flush: true);
                        savedTransactionCardWithdrawFeeEdit.add(savingsCardTransactionFee1);
                    }
                }else{
                    SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCard.id,
                            startAmount:params.cardWithdrwlStartAm,
                            endAmount:params.cardWithdrwlEndAm,
                            rateType:params.cardWithdrwlRateType,
                            rate:params.cardWithdrwlRate,
                            type: 2
                    )
                    SavingsTransactionFee savingsCardTransactionFee1  = savingsCardTransactionFee.save(flush: true);
                    savedTransactionCardWithdrawFeeEdit.add(savingsCardTransactionFee1);
                }
            }
            //end card withdraw table
            //card transfer table
            if(params.cardTransferStartAm){
                if(params.cardTransferStartAm.class.isArray()){
                    List tempCardTransferStartAmount = params.cardTransferStartAm
                    List tempCardTransferEndAmount = params.cardTransferEndAmount
                    List tempCardTransferRateType = params.cardTransferRateType
                    List tempCardTransferRate = params.cardTransferRate

                    for (int i = 0; i < tempCardTransferStartAmount.size(); i++){
                        SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCard.id,
                                startAmount:tempCardTransferStartAmount[i],
                                endAmount:tempCardTransferEndAmount[i],
                                rateType:tempCardTransferRateType[i],
                                rate:tempCardTransferRate[i],
                                type: 3
                        )
                        SavingsTransactionFee savingsCardTransactionFee1 = savingsCardTransactionFee.save(flush: true);
                        savedTransactionCardTransferFeeEdit.add(savingsCardTransactionFee1);
                    }
                }else{
                    SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCard.id,
                            startAmount:params.cardTransferStartAm,
                            endAmount:params.cardTransferEndAmount,
                            rateType:params.cardTransferRateType,
                            rate:params.cardTransferRate,
                            type: 3
                    )
                    SavingsTransactionFee savingsCardTransactionFee1  = savingsCardTransactionFee.save(flush: true);
                    savedTransactionCardTransferFeeEdit.add(savingsCardTransactionFee1);
                }
            }
            //end card transfer table

            def queryChequeTable = SavingsTransactionFee.where {transactionId == savingsTransactionGetCheque.id}
            queryChequeTable.deleteAll();

            def savedTransactionChequeDepositFeeEdit = [];
            def savedTransactionChequeWithdrawFeeEdit = [];
            def savedTransactionChequeTransferFeeEdit = [];

            //cheque deposit table
            if(params.chequeStart){
                if(params.chequeStart.class.isArray()){
                    List tempChequeStart = params.chequeStart
                    List tempChequeEnd = params.chequeEnd
                    List tempChequeRateType = params.chequeRateType
                    List tempChequeRate = params.chequeRate

                    for (int i = 0; i < tempChequeStart.size(); i++){
                        SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCheque.id,
                                startAmount:tempChequeStart[i],
                                endAmount:tempChequeEnd[i],
                                rateType:tempChequeRateType[i],
                                rate:tempChequeRate[i],
                                type: 1
                        )
                        SavingsTransactionFee savingsChequeTransactionFee1 = savingsChequeTransactionFee.save(flush: true);
                        savedTransactionChequeDepositFeeEdit.add(savingsChequeTransactionFee1);
                    }
                }else{
                    //def savedInterest;
                    SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCheque.id,
                            startAmount:params.chequeStart,
                            endAmount:params.chequeEnd,
                            rateType:params.chequeRateType,
                            rate:params.chequeRate,
                            type: 1
                    )
                    SavingsTransactionFee savingsChequeTransactionFee1  = savingsChequeTransactionFee.save(flush: true);
                    savedTransactionChequeDepositFeeEdit.add(savingsChequeTransactionFee1);
                }
            }
            //end cheque deposit table
            //cheque withdraw table
            if(params.chequeWithdrwlStartAm){
                if(params.chequeWithdrwlStartAm.class.isArray()){
                    List tempChequeWithdrwlStartAm = params.chequeWithdrwlStartAm
                    List tempChequeWithdrwlEndAm = params.chequeWithdrwlEndAm
                    List tempChequeWithdrwlRateType = params.chequeWithdrwlRateType
                    List tempChequeWithdrwlRate = params.chequeWithdrwlRate

                    for (int i = 0; i < tempChequeWithdrwlStartAm.size(); i++){
                        SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCheque.id,
                                startAmount:tempChequeWithdrwlStartAm[i],
                                endAmount:tempChequeWithdrwlEndAm[i],
                                rateType:tempChequeWithdrwlRateType[i],
                                rate:tempChequeWithdrwlRate[i],
                                type: 2
                        )
                        SavingsTransactionFee savingsChequeTransactionFee1 = savingsChequeTransactionFee.save(flush: true);
                        savedTransactionChequeWithdrawFeeEdit.add(savingsChequeTransactionFee1);
                    }
                }else{
                    SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCheque.id,
                            startAmount:params.chequeWithdrwlStartAm,
                            endAmount:params.chequeWithdrwlEndAm,
                            rateType:params.chequeWithdrwlRateType,
                            rate:params.chequeWithdrwlRate,
                            type: 2
                    )
                    SavingsTransactionFee savingsChequeTransactionFee1  = savingsChequeTransactionFee.save(flush: true);
                    savedTransactionChequeWithdrawFeeEdit.add(savingsChequeTransactionFee1);
                }
            }
            //end cheque withdraw table
            //cheque transfer table
            if(params.chequeTransferStartAm){
                if(params.chequeTransferStartAm.class.isArray()){
                    List tempChequeTransferStartAmount = params.chequeTransferStartAm
                    List tempChequeTransferEndAmount = params.chequeTransferEndAm
                    List tempChequeTransferRateType = params.chequeTransferRateType
                    List tempChequeTransferRate = params.chequeTransferRate

                    for (int i = 0; i < tempChequeTransferStartAmount.size(); i++){
                        SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                                transactionId:savingsTransactionGetCheque.id,
                                startAmount:tempChequeTransferStartAmount[i],
                                endAmount:tempChequeTransferEndAmount[i],
                                rateType:tempChequeTransferRateType[i],
                                rate:tempChequeTransferRate[i],
                                type: 3
                        )
                        SavingsTransactionFee savingsChequeTransactionFee1 = savingsChequeTransactionFee.save(flush: true);
                        savedTransactionChequeTransferFeeEdit.add(savingsChequeTransactionFee1);
                    }
                }else{
                    SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransactionGetCheque.id,
                            startAmount:params.chequeTransferStartAm,
                            endAmount:params.chequeTransferEndAm,
                            rateType:params.chequeTransferRateType,
                            rate:params.chequeTransferRate,
                            type: 3
                    )
                    SavingsTransactionFee savingsChequeTransactionFee1  = savingsChequeTransactionFee.save(flush: true);
                    savedTransactionChequeTransferFeeEdit.add(savingsChequeTransactionFee1);
                }
            }
            //end cheque transfer table

            def productInfo = SavingsProduct.findById(productId);
            def interestInfo = SavingsInterest.findAllByProductId(productId);
            def currencyList = Currencys.findAll();
            def clientCategoryList = ClientCategory.findAll();

            render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                    model: [savingsProductTranCash: savingsTransactionGetCash, savingsProductTranCheque: savingsTransactionGetCheque, savingsProductTranCard: savingsTransactionGetCard,
                            template: ProductUtility.templateList[params.int('templateNo') + 1],
                            cashDepositFeeTable: savedTransactionCashDepositFeeEdit,
                            cashWithdrawFeeTable: savedTransactionCashWithdrawFeeEdit,
                            cashTransferFeeTable: savedTransactionCashTransferFeeEdit,
                            cardDepositFeeTable: savedTransactionCardDepositFeeEdit,
                            cardWithdrawFeeTable: savedTransactionCardWithdrawFeeEdit,
                            cardTransferFeeTable: savedTransactionCardTransferFeeEdit,
                            chequeDepositFeeTable: savedTransactionChequeDepositFeeEdit,
                            chequeWithdrawFeeTable: savedTransactionChequeWithdrawFeeEdit,
                            chequeTransferFeeTable: savedTransactionChequeTransferFeeEdit,
                            decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2,
                            circleName: CircleName, rateType: RateType, calculatedAmountType: CalculatedAmount,
                            savingsProduct: productInfo, savingsInterest: interestInfo,
                            currency: currencyList, clientCategory: clientCategoryList])

            return;
        }
        //end edit cash,card, cheque

        SavingsTransaction savingsTransaction = new SavingsTransaction(
                                                        depositMin: cashDepositMin,
                                                        depositMax: cashDepositMax,
                                                        withdrawMin: cashWithdrawMin,
                                                        withdrawMax: cashWithdrawMax,
                                                        transferMin: cashTransferMin,
                                                        transferMax: cashTransferMax,
                                                        typeId: 1,
                                                        productId: productId
                                                        );
        savingsTransaction.save(flush: true);
        SavingsTransaction savingsTransaction1 = new SavingsTransaction(
                                                        depositMin: chequeDepositMin,
                                                        depositMax: chequeDepositMax,
                                                        withdrawMin: chequeWithdrawMin,
                                                        withdrawMax: chequeWithdrawMax,
                                                        transferMin: chequeTransferMin,
                                                        transferMax: chequeTransferMax,
                                                        typeId: 2,
                                                        productId: productId
                                                        );
        savingsTransaction1.save(flush: true);
        SavingsTransaction savingsTransaction2 = new SavingsTransaction(
                                                        depositMin: cardDepositMin,
                                                        depositMax: cardDepositMax,
                                                        withdrawMin: cardWithdrawMin,
                                                        withdrawMax: cardWithdrawMax,
                                                        transferMin: cardTransferMin,
                                                        transferMax: cardTransferMax,
                                                        typeId: 3,
                                                        productId: productId
                                                        );
        savingsTransaction2.save(flush: true);

        def savedTransactionCashDepositFee = [];
        def savedTransactionCashWithdrawFee = [];
        def savedTransactionCashTransferFee = [];

        def savedTransactionCardDepositFee = [];
        def savedTransactionCardWithdrawFee = [];
        def savedTransactionCardTransferFee = [];

        def savedTransactionChequeDepositFee = [];
        def savedTransactionChequeWithdrawFee = [];
        def savedTransactionChequeTransferFee = [];

        //cash deposit table
        if(params.cashStart){
            if(params.cashStart.class.isArray()){
                List tempCashStart = params.cashStart
                List tempCashEnd = params.cashEnd
                List tempCashRateType = params.cashRateType
                List tempCashRate = params.cashRate

                for (int i = 0; i < tempCashStart.size(); i++){
                    SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction.id,
                            startAmount:tempCashStart[i],
                            endAmount:tempCashEnd[i],
                            rateType:tempCashRateType[i],
                            rate:tempCashRate[i],
                            type: 1
                    )
                    SavingsTransactionFee savingsTransactionFee1 = savingsTransactionFee.save(flush: true);
                    savedTransactionCashDepositFee.add(savingsTransactionFee1);
                }
            }else{
                //def savedInterest;
                SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction.id,
                        startAmount:params.cashStart,
                        endAmount:params.cashEnd,
                        rateType:params.cashRateType,
                        rate:params.cashRate,
                        type: 1
                )
                SavingsTransactionFee savingsTransactionFee1  = savingsTransactionFee.save(flush: true);
                savedTransactionCashDepositFee.add(savingsTransactionFee1);
            }
        }
        //end cash deposit table
        //cash withdraw table
        if(params.withdrwlStartAm){
            if(params.withdrwlStartAm.class.isArray()){
                List tempwithdrwlStartAm = params.withdrwlStartAm
                List tempwithdrwlEndAm = params.withdrwlEndAm
                List tempwithdrwlRateType = params.withdrwlRateType
                List tempwithdrwlRate = params.withdrwlRate

                for (int i = 0; i < tempwithdrwlStartAm.size(); i++){
                    SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction.id,
                            startAmount:tempwithdrwlStartAm[i],
                            endAmount:tempwithdrwlEndAm[i],
                            rateType:tempwithdrwlRateType[i],
                            rate:tempwithdrwlRate[i],
                            type: 2
                    )
                    SavingsTransactionFee savingsTransactionFee1 = savingsTransactionFee.save(flush: true);
                    savedTransactionCashWithdrawFee.add(savingsTransactionFee1);
                }
            }else{
                SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction.id,
                        startAmount:params.withdrwlStartAm,
                        endAmount:params.withdrwlEndAm,
                        rateType:params.withdrwlRateType,
                        rate:params.withdrwlRate,
                        type: 2
                )
                SavingsTransactionFee savingsTransactionFee1  = savingsTransactionFee.save(flush: true);
                savedTransactionCashWithdrawFee.add(savingsTransactionFee1);
            }
        }
        //end cash withdraw table
        //cash transfer table
        if(params.transferStartAmount){
            if(params.transferStartAmount.class.isArray()){
                List tempTransferStartAmount = params.transferStartAmount
                List tempTransferEndAmount = params.transferEndAmount
                List tempTransferRateType = params.transferRateType
                List tempTransferRate = params.transferRate

                for (int i = 0; i < tempTransferStartAmount.size(); i++){
                    SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction.id,
                            startAmount:tempTransferStartAmount[i],
                            endAmount:tempTransferEndAmount[i],
                            rateType:tempTransferRateType[i],
                            rate:tempTransferRate[i],
                            type: 3
                    )
                    SavingsTransactionFee savingsTransactionFee1 = savingsTransactionFee.save(flush: true);
                    savedTransactionCashTransferFee.add(savingsTransactionFee1);
                }
            }else{
                SavingsTransactionFee savingsTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction.id,
                        startAmount:params.transferStartAmount,
                        endAmount:params.transferEndAmount,
                        rateType:params.transferRateType,
                        rate:params.transferRate,
                        type: 3
                )
                SavingsTransactionFee savingsTransactionFee1  = savingsTransactionFee.save(flush: true);
                savedTransactionCashTransferFee.add(savingsTransactionFee1);
            }
        }
        //end cash transfer table

        //card deposit table
        if(params.cardStart){
            if(params.cardStart.class.isArray()){
                List tempCardStart = params.cardStart
                List tempCardEnd = params.cardEnd
                List tempCardRateType = params.cardRateType
                List tempCardRate = params.cardRate

                for (int i = 0; i < tempCardStart.size(); i++){
                    SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction2.id,
                            startAmount:tempCardStart[i],
                            endAmount:tempCardEnd[i],
                            rateType:tempCardRateType[i],
                            rate:tempCardRate[i],
                            type: 1
                    )
                    SavingsTransactionFee savingsCardTransactionFee1 = savingsCardTransactionFee.save(flush: true);
                    savedTransactionCardDepositFee.add(savingsCardTransactionFee1);
                }
            }else{
                //def savedInterest;
                SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction2.id,
                        startAmount:params.cardStart,
                        endAmount:params.cardEnd,
                        rateType:params.cardRateType,
                        rate:params.cardRate,
                        type: 1
                )
                SavingsTransactionFee savingsCardTransactionFee1  = savingsCardTransactionFee.save(flush: true);
                savedTransactionCardDepositFee.add(savingsCardTransactionFee1);
            }
        }
        //end card deposit table
        //card withdraw table
        if(params.cardWithdrwlStartAm){
            if(params.cardWithdrwlStartAm.class.isArray()){
                List tempCardWithdrwlStartAm = params.cardWithdrwlStartAm
                List tempCardWithdrwlEndAm = params.cardWithdrwlEndAm
                List tempCardWithdrwlRateType = params.cardWithdrwlRateType
                List tempCardWithdrwlRate = params.cardWithdrwlRate

                for (int i = 0; i < tempCardWithdrwlStartAm.size(); i++){
                    SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction2.id,
                            startAmount:tempCardWithdrwlStartAm[i],
                            endAmount:tempCardWithdrwlEndAm[i],
                            rateType:tempCardWithdrwlRateType[i],
                            rate:tempCardWithdrwlRate[i],
                            type: 2
                    )
                    SavingsTransactionFee savingsCardTransactionFee1 = savingsCardTransactionFee.save(flush: true);
                    savedTransactionCardWithdrawFee.add(savingsCardTransactionFee1);
                }
            }else{
                SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction2.id,
                        startAmount:params.cardWithdrwlStartAm,
                        endAmount:params.cardWithdrwlEndAm,
                        rateType:params.cardWithdrwlRateType,
                        rate:params.cardWithdrwlRate,
                        type: 2
                )
                SavingsTransactionFee savingsCardTransactionFee1  = savingsCardTransactionFee.save(flush: true);
                savedTransactionCardWithdrawFee.add(savingsCardTransactionFee1);
            }
        }
        //end card withdraw table
        //card transfer table
        if(params.cardTransferStartAm){
            if(params.cardTransferStartAm.class.isArray()){
                List tempCardTransferStartAmount = params.cardTransferStartAm
                List tempCardTransferEndAmount = params.cardTransferEndAmount
                List tempCardTransferRateType = params.cardTransferRateType
                List tempCardTransferRate = params.cardTransferRate

                for (int i = 0; i < tempCardTransferStartAmount.size(); i++){
                    SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction2.id,
                            startAmount:tempCardTransferStartAmount[i],
                            endAmount:tempCardTransferEndAmount[i],
                            rateType:tempCardTransferRateType[i],
                            rate:tempCardTransferRate[i],
                            type: 3
                    )
                    SavingsTransactionFee savingsCardTransactionFee1 = savingsCardTransactionFee.save(flush: true);
                    savedTransactionCardTransferFee.add(savingsCardTransactionFee1);
                }
            }else{
                SavingsTransactionFee savingsCardTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction2.id,
                        startAmount:params.cardTransferStartAm,
                        endAmount:params.cardTransferEndAmount,
                        rateType:params.cardTransferRateType,
                        rate:params.cardTransferRate,
                        type: 3
                )
                SavingsTransactionFee savingsCardTransactionFee1  = savingsCardTransactionFee.save(flush: true);
                savedTransactionCardTransferFee.add(savingsCardTransactionFee1);
            }
        }
        //end card transfer table

        //cheque deposit table
        if(params.chequeStart){
            if(params.chequeStart.class.isArray()){
                List tempChequeStart = params.chequeStart
                List tempChequeEnd = params.chequeEnd
                List tempChequeRateType = params.chequeRateType
                List tempChequeRate = params.chequeRate

                for (int i = 0; i < tempChequeStart.size(); i++){
                    SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction1.id,
                            startAmount:tempChequeStart[i],
                            endAmount:tempChequeEnd[i],
                            rateType:tempChequeRateType[i],
                            rate:tempChequeRate[i],
                            type: 1
                    )
                    SavingsTransactionFee savingsChequeTransactionFee1 = savingsChequeTransactionFee.save(flush: true);
                    savedTransactionChequeDepositFee.add(savingsChequeTransactionFee1);
                }
            }else{
                //def savedInterest;
                SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction1.id,
                        startAmount:params.chequeStart,
                        endAmount:params.chequeEnd,
                        rateType:params.chequeRateType,
                        rate:params.chequeRate,
                        type: 1
                )
                SavingsTransactionFee savingsChequeTransactionFee1  = savingsChequeTransactionFee.save(flush: true);
                savedTransactionChequeDepositFee.add(savingsChequeTransactionFee1);
            }
        }
        //end cheque deposit table
        //cheque withdraw table
        if(params.chequeWithdrwlStartAm){
            if(params.chequeWithdrwlStartAm.class.isArray()){
                List tempChequeWithdrwlStartAm = params.chequeWithdrwlStartAm
                List tempChequeWithdrwlEndAm = params.chequeWithdrwlEndAm
                List tempChequeWithdrwlRateType = params.chequeWithdrwlRateType
                List tempChequeWithdrwlRate = params.chequeWithdrwlRate

                for (int i = 0; i < tempChequeWithdrwlStartAm.size(); i++){
                    SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction1.id,
                            startAmount:tempChequeWithdrwlStartAm[i],
                            endAmount:tempChequeWithdrwlEndAm[i],
                            rateType:tempChequeWithdrwlRateType[i],
                            rate:tempChequeWithdrwlRate[i],
                            type: 2
                    )
                    SavingsTransactionFee savingsChequeTransactionFee1 = savingsChequeTransactionFee.save(flush: true);
                    savedTransactionChequeWithdrawFee.add(savingsChequeTransactionFee1);
                }
            }else{
                SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction1.id,
                        startAmount:params.chequeWithdrwlStartAm,
                        endAmount:params.chequeWithdrwlEndAm,
                        rateType:params.chequeWithdrwlRateType,
                        rate:params.chequeWithdrwlRate,
                        type: 2
                )
                SavingsTransactionFee savingsChequeTransactionFee1  = savingsChequeTransactionFee.save(flush: true);
                savedTransactionChequeWithdrawFee.add(savingsChequeTransactionFee1);
            }
        }
        //end cheque withdraw table
        //cheque transfer table
        if(params.chequeTransferStartAm){
            if(params.chequeTransferStartAm.class.isArray()){
                List tempChequeTransferStartAmount = params.chequeTransferStartAm
                List tempChequeTransferEndAmount = params.chequeTransferEndAm
                List tempChequeTransferRateType = params.chequeTransferRateType
                List tempChequeTransferRate = params.chequeTransferRate

                for (int i = 0; i < tempChequeTransferStartAmount.size(); i++){
                    SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                            transactionId:savingsTransaction1.id,
                            startAmount:tempChequeTransferStartAmount[i],
                            endAmount:tempChequeTransferEndAmount[i],
                            rateType:tempChequeTransferRateType[i],
                            rate:tempChequeTransferRate[i],
                            type: 3
                    )
                    SavingsTransactionFee savingsChequeTransactionFee1 = savingsChequeTransactionFee.save(flush: true);
                    savedTransactionChequeTransferFee.add(savingsChequeTransactionFee1);
                }
            }else{
                SavingsTransactionFee savingsChequeTransactionFee = new SavingsTransactionFee(
                        transactionId:savingsTransaction1.id,
                        startAmount:params.chequeTransferStartAm,
                        endAmount:params.chequeTransferEndAm,
                        rateType:params.chequeTransferRateType,
                        rate:params.chequeTransferRate,
                        type: 3
                )
                SavingsTransactionFee savingsChequeTransactionFee1  = savingsChequeTransactionFee.save(flush: true);
                savedTransactionChequeTransferFee.add(savingsChequeTransactionFee1);
            }
        }
        //end cheque transfer table

        def productInfo = SavingsProduct.findById(productId);
        def interestInfo = SavingsInterest.findAllByProductId(productId);
        def currencyList = Currencys.findAll();
        def clientCategoryList = ClientCategory.findAll();

        render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                model: [savingsProductTranCash: savingsTransaction, savingsProductTranCheque: savingsTransaction1, savingsProductTranCard: savingsTransaction2,
                        template: ProductUtility.templateList[params.int('templateNo') + 1],
                        cashDepositFeeTable: savedTransactionCashDepositFee,
                        cashWithdrawFeeTable: savedTransactionCashWithdrawFee,
                        cashTransferFeeTable: savedTransactionCashTransferFee,
                        cardDepositFeeTable: savedTransactionCardDepositFee,
                        cardWithdrawFeeTable: savedTransactionCardWithdrawFee,
                        cardTransferFeeTable: savedTransactionCardTransferFee,
                        chequeDepositFeeTable: savedTransactionChequeDepositFee,
                        chequeWithdrawFeeTable: savedTransactionChequeWithdrawFee,
                        chequeTransferFeeTable: savedTransactionChequeTransferFee,
                        decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2, circleName: CircleName,
                        rateType: RateType, calculatedAmountType: CalculatedAmount, productId: productId,
                        savingsProduct: productInfo, savingsInterest: interestInfo,
                        currency: currencyList, clientCategory: clientCategoryList])

    }

    def saveFee(){
        println(params);
        Long productId = params.long('productId');
        def savedEntryFee = [];
        def savedReopenFee = [];
        def savedCloseFee = [];
        def savedManageFee = [];

        def productInfo = SavingsProduct.findById(productId);
        def interestInfo = SavingsInterest.findAllByProductId(productId);
        def currencyList = Currencys.findAll();
        def clientCategoryList = ClientCategory.findAll();

        if(params.entryFeeId || params.reopenFeeId || params.closeFeeId || params.manageFeeId){
            //edit entry fee
            if(params.entryFeeId){
                def queryEntryTable = SavingsEntryFee.where {productId == productId}
                queryEntryTable.deleteAll();

                if(params.entryMin.class.isArray()){
                    List tempEntryStartAmountEdit = params.entryMin
                    List tempEntryEndAmountEdit = params.entryMax
                    List tempEntryRateTypeEdit = params.entryRateType
                    List tempEntryRateEdit = params.entryValue

                    for (int i = 0; i < tempEntryStartAmountEdit.size(); i++){
                        SavingsEntryFee savingsEntryFee = new SavingsEntryFee(
                                productId: productId,
                                min: tempEntryStartAmountEdit[i],
                                max: tempEntryEndAmountEdit[i],
                                rateType: tempEntryRateTypeEdit[i],
                                value: tempEntryRateEdit[i]
                        )
                        SavingsEntryFee savingsEntryFee1 = savingsEntryFee.save(flush: true);
                        savedEntryFee.add(savingsEntryFee1);
                    }
                }else{
                    SavingsEntryFee savingsEntryFee = new SavingsEntryFee(
                            productId: productId,
                            min: params.entryMin,
                            max: params.entryMax,
                            rateType: params.entryRateType,
                            value: params.entryValue
                    )
                    SavingsEntryFee savingsEntryFee1 = savingsEntryFee.save(flush: true);
                    savedEntryFee.add(savingsEntryFee1);
                }
            }
            //end edit entry fee

            //edit reopen fee
            if(params.reopenFeeId){
                def queryReopenTable = SavingsReopenFee.where {productId == productId}
                queryReopenTable.deleteAll();

                if(params.reopenMin.class.isArray()){
                    List tempReopenStartAmountEdit = params.reopenMin
                    List tempReopenEndAmountEdit = params.reopenMax
                    List tempReopenRateTypeEdit = params.reopenRateType
                    List tempReopenRateEdit = params.reopenValue

                    for (int i = 0; i < tempReopenStartAmountEdit.size(); i++){
                        SavingsReopenFee savingsReopenFee = new SavingsReopenFee(
                                productId: productId,
                                min: tempReopenStartAmountEdit[i],
                                max: tempReopenEndAmountEdit[i],
                                rateType: tempReopenRateTypeEdit[i],
                                value: tempReopenRateEdit[i]
                        )
                        SavingsReopenFee savingsReopenFee1 = savingsReopenFee.save(flush: true);
                        savedReopenFee.add(savingsReopenFee1);
                    }
                }else{
                    SavingsReopenFee savingsReopenFee = new SavingsReopenFee(
                            productId: productId,
                            min: params.reopenMin,
                            max: params.reopenMax,
                            rateType: params.reopenRateType,
                            value: params.reopenValue
                    )
                    SavingsReopenFee savingsReopenFee1 = savingsReopenFee.save(flush: true);
                    savedReopenFee.add(savingsReopenFee1);
                }
            }
            //end reopen entry fee

            //edit close fee
            if(params.closeFeeId){
                def queryCloseTable = SavingsCloseFee.where {productId == productId}
                queryCloseTable.deleteAll();

                if(params.closeMin.class.isArray()){
                    List tempCloseStartAmountEdit = params.closeMin
                    List tempCloseEndAmountEdit = params.closeMax
                    List tempCloseRateTypeEdit = params.closeRateType
                    List tempCloseRateEdit = params.closeValue

                    for (int i = 0; i < tempCloseStartAmountEdit.size(); i++){
                        SavingsCloseFee savingsCloseFee = new SavingsCloseFee(
                                productId: productId,
                                min: tempCloseStartAmountEdit[i],
                                max: tempCloseEndAmountEdit[i],
                                rateType: tempCloseRateTypeEdit[i],
                                value: tempCloseRateEdit[i]
                        )
                        SavingsCloseFee savingsCloseFee1 = savingsCloseFee.save(flush: true);
                        savedCloseFee.add(savingsCloseFee1);
                    }
                }else{
                    SavingsCloseFee savingsCloseFee = new SavingsCloseFee(
                            productId: productId,
                            min: params.closeMin,
                            max: params.closeMax,
                            rateType: params.closeRateType,
                            value: params.closeValue
                    )
                    SavingsCloseFee savingsCloseFee1 = savingsCloseFee.save(flush: true);
                    savedCloseFee.add(savingsCloseFee1);
                }
            }
            //end close entry fee

            //edit manage fee
            if(params.manageFeeId){
                def queryManageTable = SavingsManagementFee.where {productId == productId}
                queryManageTable.deleteAll();

                if(params.manageMin.class.isArray()){
                    List tempManageStartAmountEdit = params.manageMin
                    List tempManageEndAmountEdit = params.manageMax
                    List tempManageCircleTypeEdit = params.manageCircleType
                    List tempManageRateTypeEdit = params.manageRateType
                    List tempManageRateEdit = params.manageValue

                    for (int i = 0; i < tempManageStartAmountEdit.size(); i++){
                        SavingsManagementFee savingsManagementFee = new SavingsManagementFee(
                                productId: productId,
                                min: tempManageStartAmountEdit[i],
                                max: tempManageEndAmountEdit[i],
                                circleId: tempManageCircleTypeEdit[i],
                                rateType: tempManageRateTypeEdit[i],
                                value: tempManageRateEdit[i]
                        )
                        SavingsManagementFee savingsManagementFee1 = savingsManagementFee.save(flush: true);
                        savedManageFee.add(savingsManagementFee1);
                    }
                }else{
                    SavingsManagementFee savingsManagementFee = new SavingsManagementFee(
                            productId: productId,
                            min: params.manageMin,
                            max: params.manageMax,
                            circleId: params.manageCircleType,
                            rateType: params.manageRateType,
                            value: params.manageValue
                    )
                    SavingsManagementFee savingsManagementFee1 = savingsManagementFee.save(flush: true);
                    savedManageFee.add(savingsManagementFee1);
                }
            }
            //end manage entry fee

            render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                    model: [template: ProductUtility.templateList[params.int('templateNo') + 1],
                            entryFeeTable: savedEntryFee,
                            reopenFeeTable: savedReopenFee,
                            closeFeeTable: savedCloseFee,
                            manageFeeTable: savedManageFee,
                            decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2, circleName: CircleName,
                            rateType: RateType, calculatedAmountType: CalculatedAmount, productId: productId,
                            savingsProduct: productInfo, savingsInterest: interestInfo,
                            currency: currencyList, clientCategory: clientCategoryList])
            return
        }
        
        if (params.entryMin){
            if(params.entryMin.class.isArray()){
                List tempEntryStartAmount = params.entryMin
                List tempEntryEndAmount = params.entryMax
                List tempEntryRateType = params.entryRateType
                List tempEntryRate = params.entryValue

                for (int i = 0; i < tempEntryStartAmount.size(); i++){
                    SavingsEntryFee savingsEntryFee = new SavingsEntryFee(
                            productId: productId,
                            min: tempEntryStartAmount[i],
                            max: tempEntryEndAmount[i],
                            rateType: tempEntryRateType[i],
                            value: tempEntryRate[i]
                    )
                    SavingsEntryFee savingsEntryFee1 = savingsEntryFee.save(flush: true);
                    savedEntryFee.add(savingsEntryFee1);
                }
            }else{
                SavingsEntryFee savingsEntryFee = new SavingsEntryFee(
                        productId: productId,
                        min: params.entryMin,
                        max: params.entryMax,
                        rateType: params.entryRateType,
                        value: params.entryValue
                )
                SavingsEntryFee savingsEntryFee1 = savingsEntryFee.save(flush: true);
                savedEntryFee.add(savingsEntryFee1);
            }
        }

        if (params.reopenMin){
            if(params.reopenMin.class.isArray()){
                List tempReopenStartAmount = params.reopenMin
                List tempReopenEndAmount = params.reopenMax
                List tempReopenRateType = params.reopenRateType
                List tempReopenRate = params.reopenValue

                for (int i = 0; i < tempReopenStartAmount.size(); i++){
                    SavingsReopenFee savingsReopenFee = new SavingsReopenFee(
                            productId: productId,
                            min: tempReopenStartAmount[i],
                            max: tempReopenEndAmount[i],
                            rateType: tempReopenRateType[i],
                            value: tempReopenRate[i]
                    )
                    SavingsReopenFee savingsReopenFee1 = savingsReopenFee.save(flush: true);
                    savedReopenFee.add(savingsReopenFee1);
                }
            }else{
                SavingsReopenFee savingsReopenFee = new SavingsReopenFee(
                        productId: productId,
                        min: params.reopenMin,
                        max: params.reopenMax,
                        rateType: params.reopenRateType,
                        value: params.reopenValue
                )
                SavingsReopenFee savingsReopenFee1 = savingsReopenFee.save(flush: true);
                savedReopenFee.add(savingsReopenFee1);
            }
        }

        if (params.closeMin){
            if(params.closeMin.class.isArray()){
                List tempCloseStartAmount = params.closeMin
                List tempCloseEndAmount = params.closeMax
                List tempCloseRateType = params.closeRateType
                List tempCloseRate = params.closeValue

                for (int i = 0; i < tempCloseStartAmount.size(); i++){
                    SavingsCloseFee savingsCloseFee = new SavingsCloseFee(
                            productId: productId,
                            min: tempCloseStartAmount[i],
                            max: tempCloseEndAmount[i],
                            rateType: tempCloseRateType[i],
                            value: tempCloseRate[i]
                    )
                    SavingsCloseFee savingsCloseFee1 = savingsCloseFee.save(flush: true);
                    savedCloseFee.add(savingsCloseFee1);
                }
            }else{
                SavingsCloseFee savingsCloseFee = new SavingsCloseFee(
                        productId: productId,
                        min: params.closeMin,
                        max: params.closeMax,
                        rateType: params.closeRateType,
                        value: params.closeValue
                )
                SavingsCloseFee savingsCloseFee1 = savingsCloseFee.save(flush: true);
                savedCloseFee.add(savingsCloseFee1);
            }
        }

        if (params.manageMin){
            if(params.manageMin.class.isArray()){
                List tempManageStartAmount = params.manageMin
                List tempManageEndAmount = params.manageMax
                List tempManageCircleType = params.manageCircleType
                List tempManageRateType = params.manageRateType
                List tempManageRate = params.manageValue

                for (int i = 0; i < tempManageStartAmount.size(); i++){
                    SavingsManagementFee savingsManagementFee = new SavingsManagementFee(
                            productId: productId,
                            min: tempManageStartAmount[i],
                            max: tempManageEndAmount[i],
                            circleId: tempManageCircleType[i],
                            rateType: tempManageRateType[i],
                            value: tempManageRate[i]
                    )
                    SavingsManagementFee savingsManagementFee1 = savingsManagementFee.save(flush: true);
                    savedManageFee.add(savingsManagementFee1);
                }
            }else{
                SavingsManagementFee savingsManagementFee = new SavingsManagementFee(
                        productId: productId,
                        min: params.manageMin,
                        max: params.manageMax,
                        circleId: params.manageCircleType,
                        rateType: params.manageRateType,
                        value: params.manageValue
                )
                SavingsManagementFee savingsManagementFee1 = savingsManagementFee.save(flush: true);
                savedManageFee.add(savingsManagementFee1);
            }
        }

        render(view: '/coreBanking/settings/product/savings/createSavingsProduct',
                model: [template: ProductUtility.templateList[params.int('templateNo') + 1],
                        entryFeeTable: savedEntryFee,
                        reopenFeeTable: savedReopenFee,
                        closeFeeTable: savedCloseFee,
                        manageFeeTable: savedManageFee,
                        decimalSep: BankSetup.properties.decimalSeparator ? BankSetup.properties.decimalSeparator : 2, circleName: CircleName,
                        rateType: RateType, calculatedAmountType: CalculatedAmount, productId: productId,
                        savingsProduct: productInfo, savingsInterest: interestInfo,
                        currency: currencyList, clientCategory: clientCategoryList])
    }

    def saveOver(){

    }

    def list(){
        int sEcho = params.sEcho?params.getInt('sEcho'):1
        int iDisplayStart = params.iDisplayStart? params.getInt('iDisplayStart'):0
        int iDisplayLength = params.iDisplayLength? params.getInt('iDisplayLength'):10
        String sSortDir = params.sSortDir_0? params.sSortDir_0:'asc'
        int iSortingCol = params.iSortingCols? params.getInt('iSortingCols'):1
        //Search string, use or logic to all fields that required to include
        String sSearch = params.sSearch?params.sSearch:null
        if(sSearch){
            sSearch = "%"+sSearch+"%"
        }
        String sortColumn = ProductUtility.getSortColumn(iSortingCol)
        List dataReturns = new ArrayList()

        def c = SavingsProduct.createCriteria()
        def results = c.list (max: iDisplayLength, offset:iDisplayStart) {
            /*and {
                'ne'('username',loggedUserName)
                eq("status", true)
            }*/
            if(sSearch){
                or {
                    ilike('productName',sSearch)
                    ilike('productCode',sSearch)
                }
            }
            order(sortColumn, sSortDir)
        }
        int totalCount = results.totalCount
        int serial = iDisplayStart;
        if(totalCount>0){
            if(sSortDir.equalsIgnoreCase('desc')){
                serial =(totalCount+1)-iDisplayStart
            }
            results.each {SavingsProduct savingsProduct ->
                if(sSortDir.equalsIgnoreCase('asc')){
                    serial++
                }else{
                    serial--
                }
                dataReturns.add([DT_RowId:savingsProduct.id,0:serial,1:savingsProduct.productName,2:savingsProduct.productCode,3:''])
            }
        }
        Map gridData =[iTotalRecords:totalCount,iTotalDisplayRecords:totalCount,aaData:dataReturns]
        String result = gridData as JSON
        render result
    }

    def edit(){

    }

    def delete(){

    }
}

class ProductCommand{
    String productName;
    String productCode;
    Long currencyId;
    //Long subscription;
    Double initialAmountMin;
    Double initialAmountMax;
    Double balanceMin;
    Double balanceMax;
    Long productId;

    static constraints = {
        productName nullable: false;
        productCode nullable: false;
        currencyId nullable: false;
        //subscription nullable: false;
        initialAmountMin nullable: false;
    }
}

class TransactionFeeCommand{
    Double minCashTransaction;
    Double maxCashTransaction;
    Double minCashWithdrw;
    Double maxCashWithdrw;
    Double minCashTransfer;
    Double maxCashTransfer;

    static constraints = {
        minCashTransaction nullable: false;
        maxCashTransaction nullable: false;
        minCashWithdrw nullable: false;
        maxCashWithdrw nullable: false;
        minCashTransfer nullable: false;
        maxCashTransfer nullable: false;
    }
}

