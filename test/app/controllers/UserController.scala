// Borrowed from lucidsoftware/rules_play_routes
package rulesplayroutes.test

import javax.inject.Inject
import play.api.mvc._

class UserController @Inject() (cc: ControllerComponents) extends AbstractController(cc)  {

  def ok(user: User) = Action { request =>
    Ok
  }

}