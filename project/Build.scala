import sbt._
import Keys._

object CodexBuild extends Build {

  lazy val exercises =
    Project(id = "codex",
      base = file(".")) settings {
        libraryDependencies ++= Seq(
          "org.specs2" %% "specs2" % "1.11" % "test")
      }

}

