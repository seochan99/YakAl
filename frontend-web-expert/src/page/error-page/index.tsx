import { isRouteErrorResponse, useRouteError } from "react-router-dom";
import WarningPage from "@/component/warning-page";

export default function ErrorPage() {
  const error = useRouteError();

  if (isRouteErrorResponse(error)) {
    if (error.status === 404) {
      return (
        <WarningPage
          icon=":("
          title="404 Error"
          subtitle="죄송합니다. 페이지를 찾을 수 없습니다."
          description={
            <>
              페이지가 존재하지 않거나 사용할 수 없는 페이지입니다.
              <br />
              입력하신 주소가 정확한지 다시 한 번 확인해주세요.
            </>
          }
        />
      );
    }
  } else {
    return <WarningPage icon=":(" title="Error Page" />;
  }
}
