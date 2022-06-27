import io.gatling.core.Predef._    // required for Gatling core structure DSL
import io.gatling.jdbc.Predef._    // can be omitted if you don't use jdbcFeeder
import io.gatling.http.Predef._    // required for Gatling HTTP DSL
import scala.concurrent.duration._

class GET_VehicleDetails_GatlingONLY extends Simulation {
  val carRegosFeeder = csv("../resources/data/carRegos.csv").circular

  def getVehicleDetails() = {
    repeat(15) {
      feed(carRegosFeeder).exec(http("Get specific car rego")
        .get("/data/#{rego}")
        .check(status.is(200))
        .check(jsonPath("$.year").ofType[String])
        .check(jsonPath("$.make").ofType[String])
        .check(jsonPath("$.model").ofType[String])
        .check(jsonPath("$.transmission").ofType[String])
        .check(jsonPath("$.odometer").ofType[String])
        .check(jsonPath("$.rego").is("#{rego}"))
        .check(jsonPath("$.state").ofType[String])
        .check(jsonPath("$.addressModel[*].addressType").ofType[String])
        .check(jsonPath("$.addressModel[*].address1").ofType[String])
        .check(jsonPath("$.addressModel[*].address2").ofType[String])
        .check(jsonPath("$.addressModel[*].state").ofType[String])
        .check(jsonPath("$.addressModel[*].postcode").ofType[String])
        .check(jsonPath("$.addressModel[*].country").ofType[String])
        .check(jsonPath("$.owner[*].fullName").ofType[String])
        .check(jsonPath("$.owner[*].isCurrentOwner").ofType[Boolean])
        .check(jsonPath("$.owner[*].license").ofType[String])
      )
    }
  }
  val scn = scenario("Successfully return vehicle details")
    .exec(getVehicleDetails())

  val vUsers = 1
  val duration = 10 second
  val url = http.baseUrl("http://localhost:8500")

  setUp(
    scn.inject(constantUsersPerSec(vUsers).during(duration).randomized),
  ).protocols(url)
}

