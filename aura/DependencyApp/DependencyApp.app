<aura:application access="GLOBAL" extends="ltng:outApp">
    <aura:registerEvent name="configEvent" type="c:ConfigEvent" />
    <!--aura:dependency resource="c:externalConfiguratorApp" /-->
    <aura:attribute name="inputValue" type="String" />
    <Lightning:card>
        <c:externalConfiguratorApp onvaluechange="{!c.getValueFromLwc}" /><br />
        The value from Lwc is :- {!v.inputValue}
    </Lightning:card>
</aura:application>