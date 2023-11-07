import { useNavigate } from "react-router-dom";
import { useEffect } from "react";
import { logOnDev } from "@util/log-on-dev.ts";
import { Cookies } from "react-cookie";
import { authAxios } from "@api/auth/instance.ts";
import { ExpertUserViewModel } from "@page/main/view.model.ts";

export function useAfterSocialLoginViewController() {
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

    cookies.remove("accessToken", { path: "/" });

    ExpertUserViewModel.fetch();
  }, [navigate]);
}
