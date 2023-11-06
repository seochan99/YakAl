import * as S from "./style.ts";
import Header from "@layout/header/view.tsx";
import Footer from "../../layout/footer/view.tsx";
import useAdminLoginViewController from "@page/admin-login/view.controller.ts";
import YakalSnackbar from "@components/snackbar/view.tsx";
import { ESnackbarType } from "@type/enum/snackbar-type.ts";

function AdminLogin() {
  const {
    username,
    onChangeUsername,
    password,
    onChangePassword,
    onClickLogin,
    loginButtonDisabled,
    snackbarOpen,
    setSnackbarOpen,
  } = useAdminLoginViewController();

  return (
    <S.OuterDiv>
      <Header to={"/admin"} isAdmin={true} />
      <S.CenteringMain>
        <S.UsernamePasswordDiv>
          <S.LoginTitleSpan>{"관리자 로그인"}</S.LoginTitleSpan>
          <S.TextInput
            type={"text"}
            placeholder={"Username"}
            value={username}
            onChange={onChangeUsername}
            maxLength={30}
          />
          <S.TextInput
            type={"password"}
            placeholder={"Password"}
            value={password}
            onChange={onChangePassword}
            maxLength={30}
          />
          <S.LoginButton disabled={loginButtonDisabled} onClick={onClickLogin}>
            <S.LoginButtonSpan $disabled={loginButtonDisabled}>{"로그인"}</S.LoginButtonSpan>
          </S.LoginButton>
        </S.UsernamePasswordDiv>
      </S.CenteringMain>
      <Footer />
      <YakalSnackbar open={snackbarOpen} setOpen={setSnackbarOpen} type={ESnackbarType.LOGIN_FAILED} />
    </S.OuterDiv>
  );
}

export default AdminLogin;
