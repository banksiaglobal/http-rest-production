Class Production.Rule.Router Extends Ens.Rule.Definition
{

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="Production.Test">
<ruleSet name="ZOO Router" effectiveBegin="" effectiveEnd="">
<rule name="ZOO Process Inbound Http" disabled="false">
<constraint name="source" value="Service.RESTver3"></constraint>
<when condition="1">
<send transform="Production.DataTransformation.ZOO" target="Operation.RESTver3"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
