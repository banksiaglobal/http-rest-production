Class Production.Operation.RESTver3 Extends Ens.BusinessOperation
{

Method ProcessData(pRequest As Production.Message.ZooMessage, Output pResponse As EnsLib.HTTP.GenericMessage) As %Status
{
    set tSC = $$$OK
	$$$TRACE(pRequest.RequestJSON)
	set responceStream = ##class(%Stream.GlobalCharacter).%New()
	do responceStream.Write("{""REST process"":""ver3""}")
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
