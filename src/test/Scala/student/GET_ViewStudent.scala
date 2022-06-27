
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._



class GET_ViewStudent extends Simulation{

  ///// Set Virtual Users and Duration of the Performance Test
  val vUsers = 1
  val duration = 60 second


  ///// APIs SCOPE
  val protocol = karateProtocol(
    "/student/{id}/details" -> Nil
  )

  //// Get Transaction names

  ////Setup Scenarios for Performance Test
  val ViewStudent = scenario("View an individual student's details")
    .exec(
      karateFeature( name = "classpath:Karate/Features/student/GET_viewStudent.feature")
    ).pause(5) //Gatling pause for pacing the requests

  ////Setup Workload for the Performance Test
  setUp(
    ViewStudent.inject(constantUsersPerSec(vUsers).during(duration).randomized),
  ).protocols(protocol)
}


