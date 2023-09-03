import { setCredentials } from "@/expert/store/auth.ts";
import { useEffect } from "react";
import { Cookies } from "react-cookie";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";

function SocialLoginProxy() {
  const dispatch = useDispatch();
  const navigate = useNavigate();

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    if (!accessToken) {
      navigate("/expert/login/social/failure");
    }

    dispatch(setCredentials({ token: accessToken }));

    navigate("/expert/login/identification");
  }, [dispatch, navigate]);

  return <></>;
}

export default SocialLoginProxy;
