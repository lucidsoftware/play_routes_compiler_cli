// Borrowed from lucidsoftware/rules_play_routes
package rulesplayroutes.test

import play.api.mvc._

class UserController() extends Controller {

  def ok(user: User) = Action { request =>
    Ok
  }

}