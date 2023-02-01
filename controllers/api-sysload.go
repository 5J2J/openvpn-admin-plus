package controllers

import "github.com/5J2J/openvpn-admin-plus/lib"

//APISysloadController provides system information
type APISysloadController struct {
	APIBaseController
}

// Get gives system information
// @Title Get system info
// @Description Shows OS stats
// @Success 200 request success
// @Failure 400 request failure
// @router / [get]
func (c *APISysloadController) Get() {
	c.ServeJSONData(lib.GetSystemInfo())
}
