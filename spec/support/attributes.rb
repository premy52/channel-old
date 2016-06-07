def parent_attributes(overrides = {})
	{
		corpname: "Kroger",
		hqcity: "Cincinnati",
		hqstate: "OH",
		buyerfirstname: "Nate",
		buyerlastname: "Wolecsza",
		ourbrokerfirstname: "Phil",
		ourbrokerlastname: "Storage",
		nextreviewdate: "2017-02-16",
		channel_segment: "Conventional Grocery" 
	}.merge(overrides)
end