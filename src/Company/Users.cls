/// all users
Class Company.Users Extends %Persistent
{

Property name As %String;

Property age As %Numeric;

Property sex As %Numeric;

Storage Default
{
<Data name="UsersDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>age</Value>
</Value>
<Value name="4">
<Value>sex</Value>
</Value>
<Value name="5">
<Value>Height</Value>
</Value>
</Data>
<DataLocation>^Company.UsersD</DataLocation>
<DefaultData>UsersDefaultData</DefaultData>
<IdLocation>^Company.UsersD</IdLocation>
<IndexLocation>^Company.UsersI</IndexLocation>
<StreamLocation>^Company.UsersS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Method createUser(name As %String, age As %Numeric, sex As %Numeric) As %Boolean
{
	set ##this.name = name
	set ##this.age = age
	set ##this.sex = sex
	set result = ##this.%Save()
	quit result
}

Method getUsers(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name, age, sex
	    INTO :id, :name, :age, :sex
	    FROM Company.Users
 	)
 	//вариант в массив INTO :singleUserData()
 	&sql(OPEN MyCursor)
 	
    FOR { 
   		&sql(FETCH MyCursor)
        if (SQLCODE) quit
        
        set data(id) = $ListBuild(id, name, age, sex)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

// Property Height As %String [ Required ];

}
