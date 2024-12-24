/**
 * downloadfile.js
 *
 * Copyright 2022-Present Prescient Devices, Inc.
 *
 **/

/* jshint laxbreak: true */
/* jshint esversion: 8 */
/* jshint -W030 */
/* jshint -W121 */
/* jshint forin: false */

module.exports = function (RED) {
  function DownloadFile(config) {
    RED.nodes.createNode(this, config)
    let node = this
    node.on("input", function (msg) {
	debugger
	if (!msg.hasOwnProperty("payload")) {
        node.warn(RED._("warn.no_payload"))
        return
      }
      const encoding =
        config.encoding === "none"
          ? "utf-8"
          : config.encoding === "setbymsg"
          ? msg.encoding || "utf-8"
          : config.encoding
      if (typeof msg.payload !== "string") {
          try {
	      console.log("commented out json string")
          // msg.payload = JSON.stringify(msg.payload, encoding)
        } catch (_) {
          node.warn(RED._("warn.cannot_convert_to_string"))
          return
        }
      }
      RED.events.emit("runtime-event", {
        id: `DOWNLOAD-FILE-${node.id}`,
        retain: false,
        payload: {
          filename: msg.basename || msg.filename || config.filename || "data.txt",
          data: msg.payload,
          encoding,
        },
      })
    })
  }
  RED.nodes.registerType("downloadfile", DownloadFile)
}
