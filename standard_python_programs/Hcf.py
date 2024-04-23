n1=int(input("Enter the First Number: "))
n2=int(input("ENter the Second number: "))
hcf=0
for i in range(1,n1+1):
    if n1%i==0 and n2%i==0:
        hcf=i
print(hcf)
