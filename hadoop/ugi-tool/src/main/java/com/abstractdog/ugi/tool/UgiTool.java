package com.abstractdog.ugi.tool;

import java.util.stream.Collectors;

import org.apache.hadoop.security.Credentials;
import org.apache.hadoop.security.UserGroupInformation;
import org.apache.hadoop.security.token.Token;

public class UgiTool {
  public static void main(String[] args) throws Exception {
    System.out
        .println(String.format("UserGroupInformation.isSecurityEnabled: %s", UserGroupInformation.isSecurityEnabled()));
    System.out.println(
        String.format("UserGroupInformation.isLoginKeytabBased: %s", UserGroupInformation.isLoginKeytabBased()));
    System.out.println(
        String.format("UserGroupInformation.isLoginTicketBased: %s", UserGroupInformation.isLoginTicketBased()));

    UserGroupInformation ugiCurrent = UserGroupInformation.getCurrentUser();
    UserGroupInformation ugiLogin = UserGroupInformation.getLoginUser();

    System.out.println(String.format("ugiCurrent: %s, hasKerberosCredentials: %s, credentials: %s, tokens: %s",
        ugiCurrent, ugiCurrent.hasKerberosCredentials(),
        UgiTool.getCredentialsInfo(ugiCurrent.getCredentials(), "ugiCurrent"), ugiCurrent.getTokens()));

    System.out.println(String.format("ugiLogin: %s, hasKerberosCredentials: %s, credentials: %s, tokens: %s", ugiLogin,
        ugiLogin.hasKerberosCredentials(), UgiTool.getCredentialsInfo(ugiLogin.getCredentials(), "ugiLogin"),
        ugiLogin.getTokens()));
  }

  public static String getCredentialsInfo(Credentials credentials, String identifier) {
    if (credentials == null) {
      return "Credentials: #" + identifier + "Tokens=null";
    }

    StringBuilder sb = new StringBuilder();
    sb.append("Credentials: #" + identifier + "Tokens=").append(credentials.numberOfTokens());
    if (credentials.numberOfTokens() > 0) {
      sb.append(", Services=");
      sb.append(credentials.getAllTokens().stream().map(t -> String.format("%s(%s)", t.getService(), t.getKind()))
          .collect(Collectors.joining(",")));

      sb.append(", TokenDetails=");
      sb.append(credentials.getAllTokens().stream().map(Token::toString).collect(Collectors.joining(",")));
    }
    return sb.toString();
  }
}
