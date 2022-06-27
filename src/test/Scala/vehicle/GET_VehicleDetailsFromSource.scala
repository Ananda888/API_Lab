
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._


class GET_VehicleDetailsFromSource extends Simulation{

  ///// Set Virtual Users and Duration of the Performance Test
  val vUsers = 1
  val duration = 60 second


  ///// APIs SCOPE
  val protocol = karateProtocol(
    "/data/{registrationNumber}" -> Nil
  )

  //// Get Transaction names
 // protocol.nameResolver = (req, ctx) => req.getHeader("Client-Id")

  ////Setup Scenarios for Performance Test
  val getVehicleDetails = scenario("Successfully return vehicle details")
    .exec(
      karateFeature( name = "classpath:Karate/Features/Vehicle/GET_vehicleDetailsFromSource.feature")
    ).pause(5) //Gatling pause for pacing the requests

  ////Setup Workload for the Performance Test
  setUp(
    getVehicleDetails.inject(constantUsersPerSec(vUsers).during(duration).randomized),
  ).protocols(protocol)
}


