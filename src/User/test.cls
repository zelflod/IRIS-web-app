Class User.Test Extends %RegisteredObject
{

Property field1 As %String;

Property Address As TestSerial;

Parameter defaultName = "Formula";

ClassMethod DefaultName()
{
	Quit defaultName
}

Method Concatenate(par1)
{
	Quit par1_" "_##this.field1
}

}
