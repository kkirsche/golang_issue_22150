// Copyright © 2017 Kevin Kirsche <kev.kirsche[at]gmail.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cmd

import (
	"fmt"
	"net"
	"os"

	"golang.org/x/net/ipv4"

	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
)

var cfgFile string

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:   "golang_issue_22150",
	Short: "Demo issue 22150",
	Long:  `https://github.com/golang/go/issues/22150`,
	// Uncomment the following line if your bare application
	// has an action associated with it:
	Run: func(cmd *cobra.Command, args []string) {
		logrus.WithField("function", "Run()").Debugln("create a connection")
		conn, err := net.ListenPacket("ip4:icmp", "127.0.0.1")
		if err != nil {
			logrus.WithError(err).WithField("function", "Send()").Errorln("Net ListenPacket connection error")
			return
		}
		defer conn.Close()

		rawConn, err := ipv4.NewRawConn(conn)
		if err != nil {
			logrus.WithError(err).Errorln("Send() Error: Raw connection creation")
			return
		}
		rawConn.Close()
	},
}

// Execute adds all child commands to the root command sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := RootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
}
