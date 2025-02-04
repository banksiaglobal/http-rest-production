Class Production.Operation.RESTdefault Extends Ens.BusinessOperation
{

Method ProcessData(pRequest As EnsLib.HTTP.GenericMessage, Output pResponse As EnsLib.HTTP.GenericMessage) As %Status
{
    set tSC = $$$OK
    set rObj = {}.%FromJSON(pRequest.Stream)
	$$$TRACE(rObj.%ToJSON())
	set responceStream = ##class(%Stream.GlobalCharacter).%New()
	do responceStream.Write("{""REST process"":""default""}")
    set pResponse = ##class(EnsLib.HTTP.GenericMessage).%New(responceStream,,pRequest.HTTPHeaders)
	do pResponse.%Save()
    quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="EnsLib.HTTP.GenericMessage">
        <Method>ProcessData</Method>
    </MapItem> 
</MapItems>
}

}
