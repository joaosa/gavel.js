
module.exports = ->
  @Then /^Gavel will set some error for "([^"]*)"$/, (component, callback) ->

    @validate (error, result) =>
      if error
        callback new Error "Error during validation: " + error

      component = @toCamelCase(component)
      componentValidation = result[component]
      results = componentValidation['results']
      errorsCount = results.length

      if not errorsCount > 0
        callback new Error "Expected validation errors on '" + component + "', but there are no validation errors."

      callback()

  @Then /^Gavel will NOT set any errors for "([^"]*)"$/, (component, callback) ->

    @validate (error, result) =>
      if error
        callback new Error "Error during validation: " + error
      component = @toCamelCase(component)
      componentValidation = result[component]
      results = componentValidation['results']
      errorsCount = results.length

      if errorsCount > 0
        callback new Error "No errors on '" + \
          component + \
          "' expected, but there are " + \
          errorsCount + \
          " validation errors:" + \
          JSON.stringify results, null, 2


      callback()

  @Then /^Request or Response is NOT valid$/, (callback) ->
    @isValid (error, result) =>
      if result
        callback new Error "Request or Response is valid and should NOT be valid."
      callback()

  @Then /^Request or Response is valid$/, (callback) ->
    @isValid (error, result) =>
      unless result
        callback new Error "Request or Response is NOT valid and should be valid."
      callback()
