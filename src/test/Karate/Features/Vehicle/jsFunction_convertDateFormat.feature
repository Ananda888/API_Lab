Feature: Convert date format from dd/MM/yyyy to dd MMMM yyyy

  Scenario: Create and call a convert date function

    * def convertDate =
    """
     function(response_data)
      { for (var i = 0; i < response_data.data.owner.length; i++) {
          var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
          var sdf = new SimpleDateFormat('dd/MM/yyyy');
          var oldDate = response_data.data.owner[i].dateOfBirth;
          var date = sdf.parse(oldDate);
          sdf.applyPattern('dd MMMM yyyy');
          response_data.data.owner[i].dateOfBirth = sdf.format(date)
        }
        return response_data.data.owner
      }
    """
    * def dateConvert = convertDate
