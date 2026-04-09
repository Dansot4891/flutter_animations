# 블로그 이미지 AI 생성 프롬프트

## 이미지 1: Wall-clock time 개념 (섹션 2-1)

### 설명
AnimationController가 프레임 수가 아닌 실제 경과 시간 기준으로 value를 계산한다는 것을 보여주는 그래프

### 프롬프트
```
Clean, minimal technical diagram on white background. Two line graphs side by side, sharing the same axes.

Left graph title: "60fps 기기"
Right graph title: "10fps 기기"

Both graphs:
- X-axis: "시간 (ms)" from 0 to 500
- Y-axis: "value" from 0.0 to 1.0
- Same smooth curve shape (ease-in-out)

Left graph (60fps):
- The curve is drawn with approximately 30 evenly spaced dots connected by a smooth line
- Dots are small and densely packed
- Label below: "30프레임, 부드러운 곡선"

Right graph (10fps):
- The same curve shape but drawn with only 5 large dots connected by straight line segments
- Large gaps between dots, creating a staircase-like appearance
- Label below: "5프레임, 계단식 점프"

Both graphs end at exactly x=500ms, y=1.0 to emphasize they finish at the same time.

A bracket spanning both graphs at the bottom with text: "둘 다 정확히 500ms에 완료"

Style: flat design, no gradients, blue color for 60fps, red color for 10fps. Korean text labels. Technical/engineering blog style.
```

---

## 이미지 2: 프레임 타임 비교 (섹션 2-2)

### 설명
고사양/저사양 기기의 Ticker 콜백 간격 차이를 타임라인으로 보여주는 다이어그램

### 프롬프트
```
Clean, minimal technical diagram on white background. Two horizontal timelines stacked vertically, showing frame timing differences.

Top timeline - "고사양 기기 (60fps)":
- Horizontal line from 0ms to 200ms
- Vertical tick marks evenly spaced every ~16.6ms (about 12 ticks)
- Each tick is blue colored
- Small label "16.6ms" between first two ticks with a double-headed arrow
- Ticks are densely packed

Bottom timeline - "저사양 기기 (~15fps)":
- Same horizontal line from 0ms to 200ms
- Vertical tick marks spaced every ~66ms (about 3 ticks)
- Each tick is red colored
- Small label "66ms" between first two ticks with a double-headed arrow
- Ticks are sparse with large gaps

Right side annotation:
- Top: "매 프레임마다 조금씩 업데이트" with a checkmark
- Bottom: "프레임 사이 긴 공백 → 큰 value 점프" with a warning icon

Style: flat design, no gradients, minimal. Korean text labels. Technical/engineering blog style.
```

---

## 이미지 3: 원인 분석 - 스톱모션 비교 (섹션 3) ⭐ 가장 중요

### 설명
공이 아래에서 위로 올라가는 애니메이션의 중간 프레임을 스톱모션처럼 보여주는 비교 이미지. 고사양은 잔상이 촘촘하고, 저사양은 듬성듬성.

### 프롬프트
```
Clean, minimal technical diagram on white background. Side-by-side comparison of animation frames, like a stop-motion snapshot.

Two vertical columns:

Left column - "고사양 기기 (60fps)":
- A vertical dotted path line from bottom to top (about 300px tall)
- 15 small blue circles (representing a ball/widget) evenly distributed along the path from bottom to top
- Each circle has slight transparency/opacity, getting more opaque toward the top
- The circles are close together, creating a smooth trail effect
- The spacing between circles is very small and uniform
- Label at bottom: "30프레임 → 부드러운 궤적"

Right column - "저사양 기기 (프레임 드랍)":
- Same vertical dotted path line, same height
- Only 5 large red circles along the path
- Circles are spaced far apart with large gaps between them
- Each gap has a zigzag or lightning bolt symbol indicating "skipped frames"
- The movement looks jerky and discontinuous
- Label at bottom: "5프레임 → 뚝뚝 끊기는 점프"

Between the two columns, a "VS" or divider line.

Bottom annotation spanning both columns:
"같은 500ms, 같은 거리. 프레임 수만 다르다."

Style: flat design, no gradients. Blue for high-end, red for low-end. Korean text labels. Technical/engineering blog style. The contrast between smooth trail vs jerky jumps should be immediately obvious at a glance.
```

---

## 이미지 4: 해결 아이디어 - duration 조절 효과 (섹션 4, 선택사항)

### 설명
duration을 늘리면 같은 프레임 수에서도 value 변화량이 줄어든다는 것을 보여주는 비교

### 프롬프트
```
Clean, minimal technical diagram on white background. Two scenarios compared vertically.

Top scenario - "적용 전: duration 500ms, 저사양":
- Horizontal bar divided into 5 segments (representing 5 frames)
- Each segment has a large value jump label: "0.0 → 0.2 → 0.4 → 0.6 → 0.8 → 1.0"
- Red colored segments
- Arrow annotations showing large jumps between values
- Label: "프레임당 value 변화: 0.2 (큰 점프)"

Bottom scenario - "적용 후: duration 8000ms, 저사양":
- Same horizontal bar divided into 5 segments (same frame count)
- Each segment has a tiny value jump label: "0.0 → 0.0125 → 0.025 → 0.0375 → 0.05 → 0.0625"
- Green colored segments
- Arrow annotations showing small jumps between values
- Label: "프레임당 value 변화: 0.0125 (작은 점프)"

Right side conclusion box:
"같은 프레임 수, 같은 프레임 드랍
duration만 늘렸을 뿐인데
점프 폭이 16배 줄어듦"

Style: flat design, no gradients. Red for before, green for after. Korean text labels. Technical/engineering blog style.
```

---

## 공통 스타일 가이드

- 배경: 흰색 (#FFFFFF)
- 폰트: 산세리프, 깔끔한 한글 폰트
- 색상: 고사양 = 파랑(#2196F3), 저사양(문제) = 빨강(#F44336), 저사양(해결) = 초록(#4CAF50)
- 스타일: 플랫 디자인, 그라데이션 없음, 테크 블로그 느낌
- 크기: 가로 800~1200px, 세로 400~600px
- 텍스트: 한글 사용
