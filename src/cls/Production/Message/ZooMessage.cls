Class Production.Message.ZooMessage Extends EnsLib.HTTP.GenericMessage
{

Property RequestJSON As %String(MAXLEN = "");

Property CaseId As %String;

Index ZooMessageCaseIdIndex On CaseId;

Storage Default
{
<Data name="ZooMessageDefaultData">
<Subscript>"ZooMessage"</Subscript>
<Value name="1">
<Value>RequestJSON</Value>
</Value>
<Value name="2">
<Value>CaseId</Value>
</Value>
</Data>
<DefaultData>ZooMessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
