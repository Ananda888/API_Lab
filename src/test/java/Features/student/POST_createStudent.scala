package Features.student

import com.intuit.karate.gatling.PreDef.{karateFeature, karateProtocol}
import io.gatling.core.Predef.{openInjectionProfileFactory, rampUsers, scenario}
import io.gatling.core.scenario.Simulation
import io.gatling.core.structure.ScenarioBuilder
import com.intuit.karate.Runner

import scala.concurrent.duration.DurationInt
import scala.language.postfixOps


class POST_createStudent extends Simulation{
  //Define workload model
  val numUsers = 1
  val duration = 300 seconds
  val pauseTime = 5 seconds

  //Define endpoints to test

  val protocol = karateProtocol(
    "/student/create" -> Nil,

  )
  protocol.nameResolver = (req, ctx) => req.getHeader("Client-Id")
  val createNewStudent: ScenarioBuilder = scenario("New student is successfully created").exec(karateFeature("CreateStudent.feature")).pause(pauseTime)

  setUp(
    createNewStudent.inject(rampUsers(numUsers) during(duration)).protocols(protocol)
  )

}

