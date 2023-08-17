import { FooterOuter, ViewPharmIcon, ViewPharmExplain } from "./style";

function Footer() {
  return (
    <FooterOuter>
      <ViewPharmIcon onClick={() => window.location.href("https://viewpharm1.oopy.io/")} />
      <ViewPharmExplain>
        {`VIEW PHARM (뷰팜)`}
        <br />
        {`주소: 충청북도 청주시 흥덕구 오송읍 오송생명3로 31  |  전화문의 010-9229-9531`}
        <br />
        {`E-mail: Viewpharm1@gmail.com  |  사업자등록번호: 220-87-17483호`}
      </ViewPharmExplain>
    </FooterOuter>
  );
}

export default Footer;
