import {
  HeaderOuter,
  InputBox,
  LinkLogo,
  LoginBox,
  LoginButton,
  LoginHeader,
  LoginInput,
  LogoBox,
  LogoText,
  Main,
  Outer,
  Subtitle,
  Title,
  WarningText,
  YakalIcon,
} from "./style.ts";
import Footer from "@/admin/layout/footer";
import { useMediaQuery } from "react-responsive";

import AdminPanelSettingsIcon from "@mui/icons-material/AdminPanelSettings";
import React, { useState } from "react";
import { ADMIN_LOGIN_ROUTE } from "@/global/router.tsx";

export function Login() {
  const [username, setUsername] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [hasFocused, setHasFocused] = useState<boolean>(false);

  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  const handleLoginClicked = () => {
    if (!hasFocused) {
      setHasFocused(true);
    }
  };

  const handleUsernameChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setUsername(e.currentTarget.value);
  };

  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPassword(e.currentTarget.value);
  };

  const usernameIsValid = username.length > 0;
  const passwordIsValid = password.length > 0;

  return (
    <Outer>
      {!isWideMobile && (
        <HeaderOuter>
          <LinkLogo to={ADMIN_LOGIN_ROUTE}>
            <YakalIcon />
            <LogoText>
              <Title>약 알</Title>
              <Subtitle>관리자 WEB</Subtitle>
            </LogoText>
          </LinkLogo>
        </HeaderOuter>
      )}
      <Main>
        <LoginBox>
          <LogoBox>
            <YakalIcon />
            <AdminPanelSettingsIcon />
          </LogoBox>
          <LoginHeader>{"관리자 로그인"}</LoginHeader>
          <InputBox>
            <LoginInput type="text" placeholder="Username" value={username} onChange={handleUsernameChange} />
            {hasFocused && !usernameIsValid && <WarningText>{"⚠️ Username은 비어있을 수 없습니다."}</WarningText>}
            <LoginInput type="password" placeholder="Password" value={password} onChange={handlePasswordChange} />
            {hasFocused && !passwordIsValid && <WarningText>{"⚠️ Password는 비어있을 수 없습니다."}</WarningText>}
            <LoginButton onClick={handleLoginClicked}>{"로그인"}</LoginButton>
          </InputBox>
        </LoginBox>
      </Main>
      {!isWideMobile && <Footer />}
    </Outer>
  );
}