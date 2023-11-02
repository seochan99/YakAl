import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Cookies } from "react-cookie";
import { logOnDev } from "@util/log-on-dev.ts";
import { authAxios } from "@api/auth/instance.ts";

function SocialLogin() {
  const navigate = useNavigate();

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    if (!accessToken) {
      logOnDev(`🚨 [Social Login Failed] Social Login Was Done But Access Token Was Lost. Redirect To Failure Page...`);
      navigate("/login/social/failure");
      return;
    }

    logOnDev(`🔐 [Social Login Success] Social Login Is Successfully Done.`);
    logOnDev(`🔑 [Access Token Received] ${accessToken}`);

    authAxios.defaults.headers.common["Authorization"] = `Bearer ${accessToken}`;

    navigate("/login/terms");
  }, [navigate]);

  return <></>;
}

export default SocialLogin;
