Class Production.Service.ZooRESTfixed Extends EnsLib.REST.GenericService
{

Parameter DOCCLASS = "Production.Message.ZooMessage";

Method OnProcessInput(pRequestBody As %CharacterStream, pResponseBody As %CharacterStream, ByRef pAction As %String) As %Status
{
 #Dim tResponse As GenericMessage

	If $$$IsdefObject(%request) {
		#; If called from CSP, disable session and check if cached InProc object
		Set %session.UseSessionCookie=0
		Set %response.OutputSessionToken=0
		If ..KeepCSPPartition,$D($$$EnsLocalCache($$$EnsJobLocal("ConfigName"))) {
			Merge $$$EnsJobLocal("CachedObject")=$$$EnsLocalCache($$$EnsJobLocal("ConfigName"),"CachedObject")
			Merge $$$EnsJobLocal("CachedChecksum")=$$$EnsLocalCache($$$EnsJobLocal("ConfigName"),"CachedChecksum")
			Kill $$$EnsLocalCache($$$EnsJobLocal("ConfigName"))
		}
	}
	Set pResponseBody=$$$NULLOREF
	// Set tRequest=##class(EnsLib.HTTP.GenericMessage).%New(pRequestBody,,pRequestBody)
	Set tRequest=$classmethod(..#DOCCLASS,"%New",pRequestBody,,pRequestBody)
	Do pRequestBody.SetAttributeList("") ; prevent double output; we just copied them to tRequest.HTTPHeaders
	Set tSC=..resolveAndIndex(tRequest)  Quit:$$$ISERR(tSC) tSC

	If ..OneWay {
		Set tSC = ..SendRequestAsync(..TargetConfigName,tRequest)
		Set:$$$ISOK(tSC) pResponseBody("ResponseCode")="202 Accepted"
		Quit tSC
	}

	Set tSC=..SendRequestSync(..TargetConfigName,tRequest,.tResponse)  Quit:$$$ISERR(tSC) tSC
	Set pResponseBody=tResponse.Stream

	If $$$IsdefObject(%request) {
		#; Since a CSP job can become multiple business services need to preserve even if current BS does not specify it.
		If ($D($$$EnsLocalCacheRoot)||(..KeepCSPPartition&&$D($$$EnsJobLocal("CachedObject")))) {
			Set %response.AvoidPartitionCleanup=1
		}
	}

	#; Pass along Status line and selected response HTTP headers
	Set tSL="",tDoNotPassThrough=","_$ZCVT(..%ExcludeResponseHttpHeaders,"L")_",content-length,"
	Set tHasAttrs=pResponseBody.%Extends("%Library.AbstractStream")
	Set tHeaderKey="" For { Set tHeaderKey=tResponse.HTTPHeaders.Next(tHeaderKey)  Quit:""=tHeaderKey  Set tHeaderLwr=$ZCVT(tHeaderKey,"L")
		If tHasAttrs { Set:tDoNotPassThrough'[(","_tHeaderLwr_",") pResponseBody.Attributes(tHeaderKey)=tResponse.HTTPHeaders.GetAt(tHeaderKey) } ; no need to handle multiple on one line
		Else {         Set:tDoNotPassThrough'[(","_tHeaderLwr_",") pResponseBody(tHeaderKey)=tResponse.HTTPHeaders.GetAt(tHeaderKey) }
		Set:tHeaderLwr="statusline" tSL=tResponse.HTTPHeaders.GetAt(tHeaderKey)
	}
	If tHasAttrs { Set:tDoNotPassThrough'["statusline"&&$L(tSL) pResponseBody.Attributes("StatusLine")=tSL }
	Else {         Set:tDoNotPassThrough'["statusline"&&$L(tSL) pResponseBody("StatusLine")=tSL }
	Quit tSC
}

}
