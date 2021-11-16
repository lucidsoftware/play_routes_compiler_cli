// Borrowed from lucidsoftware/rules_play_routes
package rulesplayroutes.test

import javax.inject.Inject
import play.api.mvc._

class ReverseRoutesController @Inject() (cc: ControllerComponents) extends AbstractController(cc) {

  def ok(id: Int) = Action { request =>
    Ok
  }

  def anotherOk(id: Int) = Action { request =>
    Ok
  }

}