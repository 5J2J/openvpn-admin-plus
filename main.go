package main

import (
	"github.com/astaxie/beego"
	"github.com/5J2J/openvpn-admin-plus/lib"
	_ "github.com/5J2J/openvpn-admin-plus/routers"
)

func main() {
	lib.AddFuncMaps()
	beego.Run()
}
