import pymssql

conn = pymssql.connect(server='ds-enem-test.cqussdenhszy.sa-east-1.rds.amazonaws.com' , user='admin', password='*******', database='DW_ENEM'
,port=1435,autocommit = True) 

cursor = conn.cursor() 

cmd_prod_executesp = """EXEC [dbo].[exec_etl] """
cursor.execute(cmd_prod_executesp)

conn.close()

