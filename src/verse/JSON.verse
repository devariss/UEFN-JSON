JSON<public> := module:
    using { /UnrealEngine.com/JSON }

    json_value<public> := value

    (JSON:)Parse<public>(JSONString: string)<transacts><decides>: json_value = 
        (/UnrealEngine.com/JSON:)Parse[JSONString]

    ToString<public>(Builder: json_array_builder)<transacts>: string =
        var JSONString: string = "["
        for (Index->Property : Builder.Properties):
            set JSONString += "{Property}" + if (Index < Builder.Properties.Length - 1) then "," else ""
        JSONString + "]"

    ToString<public>(Builder: json_object_builder)<transacts>: string =
        var JSONString: string = "\{"
        var Index: int = 0
        for (Key->Value : Builder.PropertiesMap):
            set JSONString += "\"{Key}\":{Value}" + if (Index < Builder.PropertiesMap.Length - 1) then "," else ""
            set Index += 1
        JSONString + "\}"

    json_array_builder<public> := class:
        var Properties: []string = array{}

        Add<public>(Value: json_array_builder)<transacts>: void =
            set Properties += array { "{Value}" }

        Add<public>(Value: json_object_builder)<transacts>: void =
            set Properties += array { "{Value}" }

        Add<public>(Value: int)<transacts>: void =
            set Properties += array { "{Value}" }

        Add<public>(Value: float)<transacts>: void =
            set Properties += array { "{Value}" }

        Add<public>(Value: string)<transacts>: void =
            set Properties += array { "\"{Value}\"" }

    json_object_builder<public> := class:
        var PropertiesMap: [string]string = map{}

        Add<public>(Key: string, Value: json_object_builder)<transacts>: void =
            logic { set PropertiesMap[Key] = "{Value}" }

        Add<public>(Key: string, Value: json_array_builder)<transacts>: void =
            logic { set PropertiesMap[Key] = "{Value}" }

        Add<public>(Key: string, Value: int)<transacts>: void =
            logic { set PropertiesMap[Key] = "{Value}" }

        Add<public>(Key: string, Value: float)<transacts>: void =
            logic { set PropertiesMap[Key] = "{Value}" }

        Add<public>(Key: string, Value: string)<transacts>: void =
            logic { set PropertiesMap[Key] = "\"{Value}\"" }