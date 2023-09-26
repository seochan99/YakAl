import * as S from "../style.ts";

function Screening() {
  const arms = [
    { q: "얼마나 자주 약 복용하는 것을 잊어버리십니까?", a: 1 },
    { q: "얼마나 자주 약을 복용하지 않겠다고 결정하십니까?", a: 2 },
    { q: "얼마나 자주 약 받는 것을 잊어버리십니까?", a: 3 },
    { q: "얼마나 자주 약이 다 떨어집니까?", a: 4 },
    { q: "의사에게 가기 전, 약 복용을 빠뜨리십니까?", a: 4 },
    { q: "몸이 나아졌다고 느낄 때, 약 복용을 빠뜨리십니까?", a: 3 },
    { q: "몸이 아프다고 느낄 때, 약 복용을 빠뜨리십니까?", a: 4 },
    { q: "본인의 부주의로 얼마나 자주 약 복용을 빠뜨리십니까?", a: 1 },
    {
      q: "얼마나 자주 본인의 필요에 따라 약 용량을 바꾸십니까? (원래 복용하는 것보다 더 많게 혹은 더 적게 복용)",
      a: 1,
    },
    { q: "하루 한번이상 약을 복용해야 할 때 얼마나 자주 약 복용 하는 것을 잊어버리십니까?", a: 2 },
    { q: "얼마나 자주 약값이 비싸서 다시 약 처방 받는 것을 미루십니까?", a: 1 },
    { q: "약이 떨어지기 전에 얼마나 자주 미리 계획하여 약 처방을 다시 받습니까?", a: 4 },
  ];

  const gds = [
    { q: "요즘 자신의 생활에 만족합니까?", a: true },
    { q: "활동과 흥미가 저하되었습니까?", a: true },
    { q: "앞날에 대해서 희망적입니까?", a: false },
    { q: "대부분의 시간을 맑은 정신으로 지내십니까?", a: true },
    { q: "대부분의 시간이 행복하다고 느끼십니까?", a: true },
    { q: "지금 살아있다는 것이 아름답다고 생각합니까?", a: true },
    { q: "가끔 낙담하고 우울하다고 느낍니까?", a: false },
    { q: "지금 자신의 인생이 매우 가치가 없다고 느낍니까?", a: true },
    { q: "인생이 매우 흥미롭다고 느낍니까?", a: true },
    { q: "활력이 충만하다고 느낍니까?", a: true },
    { q: "자주 사소한 일에 마음의 동요를 느낍니까?", a: true },
    { q: "자주 울고 싶다고 느낍니까?", a: false },
    { q: "아침에 일어나는 것이 즐겁습니까?", a: true },
    { q: "결정을 내리는 것이 수월합니까?", a: true },
    { q: "마음은 이전처럼 편안합니까?", a: true },
  ];
  const gdsTotal = 12;

  const phqNine = [
    { q: "일을 하는 것에 대한 흥미나 재미가 거의 없음", a: 0 },
    { q: "가라앉는 느낌, 우울감 또는 절망감", a: 1 },
    { q: "잠들기 어렵거나 자꾸 깨어남, 혹은 너무 많이 잠", a: 2 },
    { q: "피곤함, 기력이 저하됨", a: 3 },
    { q: "식욕 저하 혹은 과식", a: 3 },
    {
      q: "내 자신이 나쁜 사람이라는 느낌 혹은 내 자신을 실패자라고 느끼거나, 나 때문에 나 자신이나 내 가족이 불행하게 되었다는 느낌",
      a: 3,
    },
    { q: "신문을 읽거나 TV를 볼 때 집중하기 어려움", a: 3 },
    {
      q: "남들이 알아챌 정도로 거동이나 말이 느림. 또는 반대로 너무 초조하고 안절부절못해서 평소보다 많이 돌아다니고 서성거림",
      a: 3,
    },
    { q: "나는 차라리 죽는 것이 낫겠다는 등의 생각, 혹은 어떤 식으로든 스스로를 자해하는 생각들", a: 3 },
  ];
  const phqNineTotal = phqNine.reduce((sum, current) => sum + current.a, 0);

  const frailty = [
    { q: "지난 일주일 간 모든 일들이 힘들게 느껴졌나요?", a: true },
    { q: "보조 기구나 타인의 도움 없이 혼자서 쉬지 않고 10개의 계단을 오르는 데 힘이 듭니까?", a: true },
    { q: "운동장 한 바퀴(400m) 정도 걷기를 할 수 있습니까?", a: false },
    { q: "지난 7일 간 중간 강도의 신체활동이나 격렬한 활동을 1회 이상 하였습니까? 단순 걷기 미포함.", a: false },
    { q: "작년 체중에 비해 지난 1년 동안 4.5kg 이상 감소하였습니까? (의도한 체중 감량은 제외)", a: true },
  ];
  const frailtyTotal = 5;

  const drinking = [
    { q: "얼마나 술을 자주 마십니까", a: 0, comment: "전혀 안 마심" },
    {
      q: "술을 마시는 날은 한 번에 몇 잔 정도 마십니까? (소주 맥주 등의 술의 종류 상관 없이 잔 수로 계산)",
      a: 1,
      comment: "3~4잔",
    },
    {
      q: "한 번의 좌석에서 소주 한 병 또는 맥주 4병 이상 마시는 경우는 얼마나 자주 있습니까?",
      a: 2,
      comment: "월 1회",
    },
    { q: "지난 1년간 한번 술을 마시기 시작하면 멈출 수 없었던 때가 얼마나 자주 있었습니까?", a: 3, comment: "주 1회" },
    {
      q: "지난 1년간 평소 같으면 할 수 있던 일을 음주 때문에 실패한 적이 얼마나 자주 있었습니까?",
      a: 4,
      comment: "거의 매일",
    },
    {
      q: "지난 1년간 술을 마신 다음날 일어나기 위해 해장술이 필요했던 적은 얼마나 자주 있었습니까?",
      a: 4,
      comment: "거의 매일",
    },
    { q: "지난 1년간 음주 후에 죄책감이 든 적이 얼마나 자주 있었습니까?", a: 4, comment: "거의 매일" },
    {
      q: "지난 1년간 음주 때문에 전날 밤에 있었던 일이 기억나지 않았던 적이 얼마나 자주 있었습니까?",
      a: 4,
      comment: "거의 매일",
    },
    { q: "음주로 인해 자신이나 다른 사람이 다친 적이 있었습니까?", a: 4, comment: "지난 1년간 있음" },
    {
      q: "친척이나 친구, 의사가 당신이 술 마시는 것을 걱저하거나 당신에게 술 끊기를 권유한 적이 있었습니까?",
      a: 4,
      comment: "지난 1년간 있음",
    },
  ];
  const drinkingTotal = drinking.reduce((sum, current) => sum + current.a, 0);

  const smoking = [
    { q: "흡연을 하고 있습니까?", a: 2, comment: "현재 피운다" },
    { q: "현재 또는 과거에 흡연을 하였으면 몇 년이나 담배를 피우셨습니까?", a: 20 },
    { q: "현재 또는 과거에 흡연을 하였으면 하루 흡연량은 얼마입니까?", a: "1/2~1갑" },
  ];

  const dementia = [
    {
      q: "판단력 문제가 있습니까? (사기를 당하거나 재정적인 문제를 잘 판단하지 못하거나, 상대방에게 맞지 않는 선물을 하는 행동 등을 한 경험이 있나요?)",
      a: 2,
    },
    { q: "취미나 활동에 대한 관심이 저하되었습니까?", a: 1 },
    { q: "같은 질문이나 이야기를 반복합니까?", a: 0 },
    { q: "도구나 기구 사용이 서툴러졌습니까? (리모콘, 비디오, 컴퓨터, 전자레인지 등)", a: 0 },
    { q: "정확히 몇 년도인지 몇 월인지를 잘 모릅니까?", a: 0 },
    {
      q: "복잡한 재정 문제를 다루기 어려워졌습니까? (세금계산, 청구서 처리, 수표거래, 은행업무 등을 이전처럼 처리하기 힘든가요?)",
      a: 0,
    },
    { q: "약속을 기억하기 어렵습니까?", a: 0 },
    { q: "사고력이나 기억력의 문제가 지속되고 있습니까?", a: 0 },
  ];
  const dementiaTotal = dementia.reduce((sum, current) => sum + (current.a === 0 ? 1 : 0), 0);

  const insomnia = [
    { q: "잠들기 어렵나요?", a: 4 },
    { q: "잠을 유지하기 어렵나요?", a: 3 },
    { q: "잠에서 쉽게 깨나요?", a: 4 },
    { q: "현재 수면 양상에 얼마나 만족하고 있나요?", a: 2 },
    { q: "당신의 수면장애를 다른 사람들이 걱정하나요?", a: 1 },
    { q: "당신은 현재 불면증에 대해서 걱정하고 있나요?", a: 0 },
    { q: "당신의 수면장애가 어느 정도나 당신의 낮의 활동을 방해한다고 생각하나요?", a: 3 },
  ];
  const insomniaTotal = insomnia.reduce((sum, current) => sum + current.a, 0);

  const osa = [
    { q: "코골이가 있나요?", a: false },
    { q: "한주간 내내 피곤한 느낌인가요?", a: true },
    { q: "자는 동안 숨을 쉬지 않는 것이 목격되나요?", a: true },
    { q: "고혈압 증세가 있나요?", a: false },
    { q: "체질량(BMI) 지수가 28 이상인가요?", a: true },
    { q: "나이가 50세 이상인가요?", a: true },
    { q: "목둘레가 남성의 경우 43cm, 여성의 경우 38cm 이상인가요?", a: false },
    { q: "남성인가요?", a: true },
  ];
  const osaTotal = osa.reduce((sum, current) => sum + (current.a ? 1 : 0), 0);

  return (
    <S.OuterDiv>
      <S.ColumnDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"복약 순응도 테스트"}</S.TitleSpan>
              <S.SubtitleSpan>{"ARMS"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.NormalSpan>{`${arms.reduce((sum, current) => sum + current.a, 0)}점 / 48점`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {arms.map((armsItem, index) => {
              const ele = [
                <S.RowDiv key={2 * index}>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{armsItem.q}</S.NormalSpan>
                  </S.LeftTitleDiv>
                  <S.RightTitleDiv>
                    <S.NormalSpan>
                      {armsItem.a === 1 && "전혀 (1점)"}
                      {armsItem.a === 2 && "가끔 (2점)"}
                      {armsItem.a === 3 && "대부분 (3점)"}
                      {armsItem.a === 4 && "항상 (4점)"}
                    </S.NormalSpan>
                  </S.RightTitleDiv>
                </S.RowDiv>,
              ];

              if (index !== arms.length - 1) {
                ele.push(<S.Bar key={2 * index + 1} />);
              }

              return ele;
            })}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"우울 척도 테스트"}</S.TitleSpan>
              <S.SubtitleSpan>{"GDS"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {gdsTotal <= 5 && "정상"}
                {6 <= gdsTotal && gdsTotal <= 10 && "중간 정도의 우울상태"}
                {11 <= gdsTotal && gdsTotal <= 15 && "중증도의 우울증"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`(${gdsTotal}점 / 15점)`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {gds.map((gdsItem, index) => {
              const ele = [
                <S.RowDiv key={2 * index}>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{gdsItem.q}</S.NormalSpan>
                  </S.LeftTitleDiv>
                  <S.RightTitleDiv>
                    <S.NormalSpan>{gdsItem.a ? "예" : "아니오"}</S.NormalSpan>
                  </S.RightTitleDiv>
                </S.RowDiv>,
              ];

              if (index !== gds.length - 1) {
                ele.push(<S.Bar key={2 * index + 1} />);
              }

              return ele;
            })}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"우울증 선별검사"}</S.TitleSpan>
              <S.SubtitleSpan>{"PHQ-9"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {0 <= phqNineTotal && phqNineTotal <= 4 && "우울증상 없음"}
                {5 <= phqNineTotal && phqNineTotal <= 9 && "가벼울 우울증상"}
                {10 <= phqNineTotal && phqNineTotal <= 19 && "중간 정도의 우울증 의심"}
                {20 <= phqNineTotal && phqNineTotal <= 27 && "심한 우울증 의심"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`(${phqNineTotal}점 / 27점)`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {phqNine.map((phqNineItem, index) => [
              <S.RowDiv key={2 * index}>
                <S.LeftTitleDiv>
                  <S.NormalSpan>{phqNineItem.q}</S.NormalSpan>
                </S.LeftTitleDiv>
                <S.RightTitleDiv>
                  <S.NormalSpan>
                    {phqNineItem.a === 0 && "전혀 아님 (0점)"}
                    {phqNineItem.a === 1 && "2~6일 (1점)"}
                    {phqNineItem.a === 2 && "7일 이상 (2점)"}
                    {phqNineItem.a === 3 && "거의 매일 (3점)"}
                  </S.NormalSpan>
                </S.RightTitleDiv>
              </S.RowDiv>,
              <S.Bar key={2 * index + 1} />,
            ])}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"노쇠 테스트"}</S.TitleSpan>
              <S.SubtitleSpan>{"Frailty"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {frailtyTotal === 0 && "건강"}
                {1 <= frailtyTotal && frailtyTotal <= 2 && "노쇠 전단계 의심"}
                {3 <= frailtyTotal && "노쇠 의심"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`(${frailtyTotal}점 / 5점)`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {frailty.map((frailtyItem, index) => [
              <S.RowDiv key={2 * index}>
                <S.LeftTitleDiv>
                  <S.NormalSpan>{frailtyItem.q}</S.NormalSpan>
                </S.LeftTitleDiv>
                <S.RightTitleDiv>
                  <S.NormalSpan>{frailtyItem.a ? "예" : "아니오"}</S.NormalSpan>
                </S.RightTitleDiv>
              </S.RowDiv>,
              <S.Bar key={2 * index + 1} />,
            ])}
          </S.ContentDiv>
        </S.CardDiv>
      </S.ColumnDiv>
      <S.ColumnDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"음주력 테스트"}</S.TitleSpan>
              <S.SubtitleSpan>{"History of Drinking"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {drinkingTotal <= 9 && "위험 수준 아님"}
                {10 <= drinkingTotal && drinkingTotal <= 15 && "습관성 과음 주의"}
                {16 <= drinkingTotal && drinkingTotal <= 19 && "위험 수준"}
                {20 <= drinkingTotal && drinkingTotal <= 40 && "매우 위험"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`(${drinkingTotal}점 / 40점)`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {drinking.map((drinkingItem, index) => [
              <S.RowDiv key={2 * index}>
                <S.LeftTitleDiv>
                  <S.NormalSpan>{drinkingItem.q}</S.NormalSpan>
                </S.LeftTitleDiv>
                <S.RightTitleDiv>
                  <S.NormalSpan>{drinkingItem.comment}</S.NormalSpan>
                </S.RightTitleDiv>
              </S.RowDiv>,
              <S.Bar key={2 * index + 1} />,
            ])}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"흡연력 테스트"}</S.TitleSpan>
              <S.SubtitleSpan>{"History of Smoking"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            <S.RowDiv>
              <S.LeftTitleDiv>
                <S.NormalSpan>
                  {smoking[0].a === 0 && "비흡연자"}
                  {smoking[0].a !== 0 && `총 흡연 기간: ${smoking[1].a}년 / 하루 흡연량: ${smoking[2].a}`}
                </S.NormalSpan>
              </S.LeftTitleDiv>
            </S.RowDiv>
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"치매 테스트"}</S.TitleSpan>
              <S.SubtitleSpan>{"Dementia"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {dementiaTotal <= 1 && "정상"}
                {2 <= dementiaTotal && "인지 기능의 변화가 의심됨"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`(${dementiaTotal}점 / 8점)`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {dementia.map((dementiaItem, index) => [
              <S.RowDiv key={2 * index}>
                <S.LeftTitleDiv>
                  <S.NormalSpan>{dementiaItem.q}</S.NormalSpan>
                </S.LeftTitleDiv>
                <S.RightTitleDiv>
                  <S.NormalSpan>
                    {dementiaItem.a === 0 && "예"}
                    {dementiaItem.a === 1 && "모르겠어요"}
                    {dementiaItem.a === 2 && "아니오"}
                  </S.NormalSpan>
                </S.RightTitleDiv>
              </S.RowDiv>,
              <S.Bar key={2 * index + 1} />,
            ])}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"불면증 심각도"}</S.TitleSpan>
              <S.SubtitleSpan>{"Insomnia"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {0 <= insomniaTotal && insomniaTotal <= 7 && "정상"}
                {8 <= insomniaTotal && insomniaTotal <= 14 && "약간의 불면증"}
                {15 <= insomniaTotal && insomniaTotal <= 21 && "중증도의 불면증"}
                {22 <= insomniaTotal && insomniaTotal <= 28 && "심한 불면증"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`(${insomniaTotal}점 / 28점)`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {insomnia.map((insomniaItem, index) => [
              <S.RowDiv key={2 * index}>
                <S.LeftTitleDiv>
                  <S.NormalSpan>{insomniaItem.q}</S.NormalSpan>
                </S.LeftTitleDiv>
                <S.RightTitleDiv>
                  <S.NormalSpan>
                    {index !== 3 && insomniaItem.a === 0 && "매우 그렇다"}
                    {index !== 3 && insomniaItem.a === 1 && "그렇다"}
                    {index !== 3 && insomniaItem.a === 2 && "보통"}
                    {index !== 3 && insomniaItem.a === 3 && "아니다"}
                    {index !== 3 && insomniaItem.a === 4 && "전혀 아니다"}
                    {index === 3 && insomniaItem.a === 4 && "매우 그렇다"}
                    {index === 3 && insomniaItem.a === 3 && "그렇다"}
                    {index === 3 && insomniaItem.a === 2 && "보통"}
                    {index === 3 && insomniaItem.a === 1 && "아니다"}
                    {index === 3 && insomniaItem.a === 0 && "전혀 아니다"}
                  </S.NormalSpan>
                </S.RightTitleDiv>
              </S.RowDiv>,
              <S.Bar key={2 * index + 1} />,
            ])}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"폐쇄성 수면 무호흡증"}</S.TitleSpan>
              <S.SubtitleSpan>{"OSA"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {osaTotal <= 2 && "정상"}
                {3 <= osaTotal && osaTotal <= 4 && "약간의 불면증"}
                {5 <= osaTotal && "중증도의 불면증"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`(${osaTotal}점 / 8점)`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {osa.map((osaItem, index) => [
              <S.RowDiv key={2 * index}>
                <S.LeftTitleDiv>
                  <S.NormalSpan>{osaItem.q}</S.NormalSpan>
                </S.LeftTitleDiv>
                <S.RightTitleDiv>
                  <S.NormalSpan>{osaItem.a ? "예" : "아니오"}</S.NormalSpan>
                </S.RightTitleDiv>
              </S.RowDiv>,
              <S.Bar key={2 * index + 1} />,
            ])}
          </S.ContentDiv>
        </S.CardDiv>
      </S.ColumnDiv>
    </S.OuterDiv>
  );
}

export default Screening;
