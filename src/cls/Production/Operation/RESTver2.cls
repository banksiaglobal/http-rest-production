Class Production.Operation.RESTver2 Extends Ens.BusinessOperation
{

Method ProcessData(pRequest As Production.Message.ZooMessage, Output pResponse As EnsLib.HTTP.GenericMessage) As %Status
{
    set tSC = $$$OK
    set rObj = {}.%FromJSON(pRequest.Stream)
	$$$TRACE(rObj.%ToJSON())
	set pRequest.CaseId = rObj.case
	do pRequest.%Save()
	set responceStream = ##class(%Stream.GlobalCharacter).%New()
	do responceStream.Write("{""REST process"":""ver2""}")
    set pResponse = ##class(EnsLib.HTTP.GenericMessage).%New(responceStream,,pRequest.HTTPHeaders)
	do pResponse.%Save()
    quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="Production.Message.ZooMessage">
        <Method>ProcessData</Method>
    </MapItem> 
</MapItems>
}

}
