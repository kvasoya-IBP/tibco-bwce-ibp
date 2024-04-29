<?xml version="1.0" encoding="ASCII"?>
<emulation:EmulationData xmlns:emulation="http:///emulation.ecore" isBW="true" location="com.imperialdade.sx.nichols.integration">
  <ProcessNode Id="implementations.PublishShipment" Name="implementations.PublishShipment" ModelType="BW" moduleName="com.imperialdade.sx.nichols.integration">
    <Operation Name="callProcess" serviceName="implementations.PublishShipment">
      <Inputs Id="fe5ff176-b11e-4d4e-9846-6064beba25c3com.imperialdade.sx.nichols.integration_implementations.PublishShipment_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="order.EDIConversion" Name="order.EDIConversion" ModelType="BW" moduleName="com.imperialdade.sx.nichols.integration">
    <Operation Name="callProcess" serviceName="order.EDIConversion">
      <Inputs Id="9f51bbed-dfd1-478e-a554-e0ae2e8ac94fcom.imperialdade.sx.nichols.integration_order.EDIConversion_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
</emulation:EmulationData>
