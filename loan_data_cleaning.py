import pandas as pd 

loan = pd.read_csv('Loan_data.csv')

# print(loan.describe())
# print(loan.shape)

# Convert ApplicationDate to datetime

loan['ApplicationDate'] = pd.to_datetime(loan['ApplicationDate'], format='%d-%m-%Y' , errors='coerce')


loan['Month'] = loan['ApplicationDate'].dt.month
loan['Year'] = loan['ApplicationDate'].dt.year


# Create Age Groups

bins = [18 , 25, 35, 45 ,55, 65  , 100]
labels = ['18-25', '26-35', '36-45' , '46-55' , '56-65', '66+']

loan['AgeGroup']= pd.cut(loan['Age'] , bins=bins , labels=labels , include_lowest=True)



# Create Credit Score Category (based on Indian banking standards)

def Credit_Score_Categor(Score):
    if Score < 550:
        return 'Poor'
    elif Score < 650 :
        return 'Fair'
    elif Score < 750 : 
        return 'Good'
    elif Score < 850 : 
        return 'Very Good'
    else :
        return 'Excellent'
    
loan['CreditScoreCategor'] = loan['CreditScore'].apply(Credit_Score_Categor)


# Calculate Debt-to-Income Ratio Percentage

loan['DebttoIncomePercent'] = (loan['MonthlyDebtPayments']/loan['MonthlyIncome'])*100


# Create DTI Risk Category

def dti_risk_category(dti):
    if dti < 20 :
        return 'Low Risk'
    elif dti <= 40:
        return 'Medium Risk'
    else :
        return 'High Risk' 
    
loan['DTIRiskCategory'] = loan['DebttoIncomePercent'].apply(dti_risk_category)


# Simplify LoanApproved column to human-readable status

loan['LoanApprovedStatus'] = loan['LoanApproved'].map({1: 'Approved', 0: 'Rejected'})

print(loan.head(20))

# Save Cleaned Dataset

loan.to_csv('Cleaned_loan_data.csv', index=False)

print('Saved')

