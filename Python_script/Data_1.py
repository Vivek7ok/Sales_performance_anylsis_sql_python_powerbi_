import pandas as pd
from sqlalchemy import create_engine

Data = pd.read_csv("D:\\Data_set\\Data_set_1\\customer_shopping_behavior.csv")

df = pd.DataFrame(Data)

df['Review Rating'] = df['Review Rating'].fillna(df.groupby('Category')['Review Rating'].transform('median'))

df.columns = df.columns.str.lower()
df.columns = df.columns.str.replace(' ','_')
df = df.rename(columns={'purchase_amount_(usd)':'purchase_amount'})
ran = [0,18,25,45,60,100]
name = ['Teen','Young','Adult','Mid Age','Senior']
df['age_group'] = pd.cut(df['age'],bins=ran,labels=name)
df = df.drop('promo_code_used',axis=1)
print(df.info())
print(df.shape)
engine = create_engine(
    "mysql+pymysql://root:Vivek%40123@localhost:3306/customer_data"
)

print(df.head())     # CHECK DATA
print(df.shape)      # MUST NOT BE (0, x)

df.to_sql(
    name='customer_sales',
    con=engine,
    if_exists='replace',   # ✅ IMPORTANT
    index=False
)


print("Data inserted successfully!")



