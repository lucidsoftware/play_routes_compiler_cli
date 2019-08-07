// Borrowed from lucidsoftware/rules_play_routes
package rulesplayroutes.test

import play.api.mvc._

class ReverseRoutesController() extends Controller {

  def ok(id: Int) = Action { request =>
    Ok
  }

}