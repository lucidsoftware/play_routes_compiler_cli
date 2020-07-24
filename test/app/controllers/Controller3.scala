// Borrowed from lucidsoftware/rules_play_routes
package rulesplayroutes.test

import javax.inject.Inject
import play.api.mvc._

class Controller3 @Inject() (cc: ControllerComponents) extends AbstractController(cc)  {

  def ok() = Action { request =>
    Ok
  }

}