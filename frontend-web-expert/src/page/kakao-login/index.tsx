import Logo from "@/layout/logo";
import { Header } from "@/layout/root/style";
import { Outer } from "../login/style";
import { Description, Div, Icon, Text } from "../error-page/style";
import { useEffect } from "react";
import { loginUsingKakao } from "@/api/auth";
import { client } from "@/api/aixos";
import { useNavigate } from "react-router-dom";
import { TOKEN_EXPIRE_MS, onSlientRefresh } from "@/util/slient-refresh";

function KakaoLogin() {
  const navigate = useNavigate();

  useEffect(() => {
    const code = new URL(window.location.href).searchParams.get("code");

    if (!code) {
      console.log("Kakao Login Error: no authorization code");
      return;
    }

    loginUsingKakao(code)
      .then((response) => {
        client.defaults.headers.common["Authorization"] = `Bearer ${response.accessToken}`;
        setTimeout(onSlientRefresh, TOKEN_EXPIRE_MS - 60 * 1000);
        localStorage.setItem("logged", "true");
        navigate("/");
      })
      .catch((error) => {
        console.log(error);
        localStorage.setItem("logged", "false");
        navigate("/login");
      });
  }, [navigate]);

  return (
    <Outer>
      <Header>
        <Logo path="/login" />
      </Header>
      <Div>
        <Icon>{":)"}</Icon>
        <Text>
          <Header>카카오 로그인 중...</Header>
          <Description>카카오로 로그인 중입니다. 잠시 기다려주세요.</Description>
        </Text>
      </Div>
    </Outer>
  );
}

export default KakaoLogin;
