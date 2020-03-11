Class Company.Users Extends %Persistent
{

/// Person first name
Property Name As %String(MAXLEN = 100, TRUNCATE = 1);

/// Person date of birth in HOROLOG
Property dob As %Integer;

/// Users count
ClassMethod Count() As %Status
{
    &sql(select COUNT(*) into :count from Company.Users)
    Return count
}

/// Create new user<br>
/// <var>Name</var> - user first name<br>
/// <var>DOB</var> - user date of birth YYYY-MM-DD<br>
ClassMethod AddUser(Name As %String = "", DOB As %String = "") As %Status
{
    set user = ..%New()
    set user.Name = Name
    set user.dob = +$ZDateTimeH(DOB, 3)
    Return user.%Save()
}

/// get all users array
ClassMethod GetData() As %Status
{
  set users = []
  set rs = ##class(%SQL.Statement).%ExecDirect(,"SELECT * FROM Company.Users")
  while rs.%Next() {
    set userObj = {
      "name": (rs.Name), 
      "dob": (rs.dob)
    }
    
    do users.%Push(userObj)
  }
  return users
}

Storage Default
{
<Data name="UsersDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>dob</Value>
</Value>
</Data>
<DataLocation>^Company.UsersD</DataLocation>
<DefaultData>UsersDefaultData</DefaultData>
<IdLocation>^Company.UsersD</IdLocation>
<IndexLocation>^Company.UsersI</IndexLocation>
<StreamLocation>^Company.UsersS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
