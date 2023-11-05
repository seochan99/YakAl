import LoadingSpinner from "@/components/loading-spinner/view";
import { useAfterSocialLoginViewController } from "@components/login/after-social-login/view.controller.ts";

function AfterSocialLoginPage() {
  useAfterSocialLoginViewController();
  return <LoadingSpinner />;
}

export default AfterSocialLoginPage;
