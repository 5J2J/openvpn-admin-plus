package main

import (
	"github.com/astaxie/beego"
	"github.com/5J2J/pivpn-tap-web-ui/lib"
	_ "github.com/5J2J/pivpn-tap-web-ui/routers"
)

func main() {
	lib.AddFuncMaps()
	beego.Run()
}
