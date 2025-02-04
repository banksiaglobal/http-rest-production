Class Production.Test Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Production.Test" LogGeneralTraceEvents="false">
  <Description>REST processing</Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Service.RESTdefault" Category="" ClassName="EnsLib.REST.GenericService" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">Operation.RESTdefault</Setting>
    <Setting Target="Adapter" Name="Port">1984</Setting>
  </Item>
  <Item Name="Service.RESTver1" Category="" ClassName="Production.Service.ZooREST" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">Operation.RESTver1</Setting>
    <Setting Target="Adapter" Name="Port">1984</Setting>
  </Item>
  <Item Name="Service.RESTver2" Category="" ClassName="Production.Service.ZooRESTfixed" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">Operation.RESTver2</Setting>
    <Setting Target="Adapter" Name="Port">1984</Setting>
  </Item>
  <Item Name="Service.RESTver3" Category="" ClassName="EnsLib.REST.GenericService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">Main.Router</Setting>
    <Setting Target="Adapter" Name="Port">1984</Setting>
  </Item>
  <Item Name="Main.Router" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="4" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Production.Rule.Router</Setting>
    <Setting Target="Host" Name="ResponseFrom">Operation.RESTver3</Setting>
  </Item>
  <Item Name="Operation.RESTdefault" ClassName="Production.Operation.RESTdefault" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.RESTver1" ClassName="Production.Operation.RESTver1" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.RESTver2" ClassName="Production.Operation.RESTver2" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Operation.RESTver3" ClassName="Production.Operation.RESTver3" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
