
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._



class POST_CreateStudent extends Simulation{

  ///// Set Virtual Users and Duration of the Performance Test
  val vUsers = 3
  val duration = 60 second


  ///// APIs SCOPE
  val protocol = karateProtocol(
    "/student/create" -> Nil
  )

  //// Get Transaction names
 // protocol.nameResolver = (req, ctx) => req.getHeader("Client-Id")

  ////Setup Scenarios for Performance Test
  val createNewStudent = scenario("Successfully Create Student")
    .exec(
      karateFeature( name = "classpath:Karate/Features/student/POST_createStudent.feature")
    ).pause(5) //Gatling pause for pacing the requests

  ////Setup Workload for the Performance Test
  setUp(
    createNewStudent.inject(constantUsersPerSec(vUsers).during(duration).randomized),
  ).protocols(protocol)
}


