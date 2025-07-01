import { useState } from "react";

export default function Home() {
    const x = Math.random();
    const arr = ["루피", "조로", "상디"];
    // if, for, forEach

    function show() {
        alert('주의');
    }

    // let count  = 0;
    const [count, setCount] = useState(0);
    // 일반 변수가 아닌 상태 변수
    // 상태 변수의 setter가 호출되면 컴포넌트는 렌더링됨

    return (
        <div>
            <h1>Home</h1>
            {/* 조건문 - 삼항연산자를 사용 */}
            <div>
                {
                    x > 0.6 ? <span>대</span> : x > 0.3 ? <span>중</span> : <span>소</span>
                }
            </div>

            {/* 반복문 - map 메서드를 사용 */}
            <div>
                {
                    arr.map((name) => (<div>{name}</div>))
                }
            </div>

            <button onClick={show}>주의</button>
            <br />
            <button onClick={() => {alert('주의2')}}>주의2</button>

            <div>count : {count}</div>
            <button onClick={() => {
                                    // count = count + 1;
                                    setCount(count + 1);
                                    alert(count);
                                    }}>count 1 증가</button>
        </div>
    )
}
