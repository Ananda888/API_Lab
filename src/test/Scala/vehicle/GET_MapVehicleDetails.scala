
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class GET_MapVehicleDetails extends Simulation{

  ///// Set Virtual Users and Duration of the Performance Test
  val vUsers = 1
  val duration = 30 second
  ///// APIs SCOPE
  val protocol = karateProtocol(
    "/data/{registrationNumber}/details" -> Nil
  )

  //// Get Transaction names
 // protocol.nameResolver = (req, ctx) => req.getHeader("Client-Id")

  ////Setup Scenarios for Performance Test
  val getMappedData = scenario("Vehicle details from response data matches the source data")
    .exec(
      karateFeature( name = "classpath:Karate/Features/Vehicle/GET_MapVehicleDetails.feature")
    ).pause(5) //Gatling pause for pacing the requests

  ////Setup Workload for the Performance Test
  setUp(
    getMappedData.inject(constantUsersPerSec(vUsers).during(duration).randomized),
  ).protocols(protocol)
}


