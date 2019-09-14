package rulesplayroutes.test

import org.specs2.mutable.Specification
import play.api.test.Helpers.{GET, route, status}
import play.api.test.{FakeApplication, FakeRequest, WithApplication}
import rulesplayroutes.test.common.TestReverseRoutesOnly
import play.api.test.Helpers._

class PlayForwardRoutesOnlyTest extends Specification {
  val app = new FakeApplication()

  "Play Routes Compiler when run through Bazel" should {
    "Compiles forward routes correctly" in new WithApplication() {
      // The play application can route this request successfully, verifying that forward routes works
      status(route(app, FakeRequest(GET, TestReverseRoutesOnly.generate(10))).get) mustEqual OK
    }
  }
}