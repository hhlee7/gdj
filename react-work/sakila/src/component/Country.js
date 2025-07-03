import { useEffect, useState } from "react";
import { Link } from "react-router-dom";

export default function Country() {
    // const countryList = [];
    const [countryList, setCountryList] = useState([]);
    const [pageNumber, setPageNumber] = useState(1);
    const [totalPages, setTotalpages] = useState(1);
    const [totalElements, setTotalElements] = useState(0);

    // API 통신 "[GET] http://localhost/country"
    useEffect(function () {
        fetch("http://localhost/countryList/" + pageNumber)
            .then(function (res) { return res.json(); })
            .then(function (data) {
                setCountryList(data.content); // data {} : Page 객체 타입 / data.content가 배열
                setTotalpages(data.totalPages);
                setTotalElements(data.totalElements);
            })
    }, [pageNumber]); // 두 번째 인자가 [](빈 배열)이면 처음 화면 렌더링 때 한 번만 useEffect() 실행

    // 페이지 그룹 계산
    const pageGroup = Math.floor((pageNumber - 1) / 10);
    const startPage = pageGroup * 10 + 1;
    const endPage = Math.min(startPage + 9, totalPages);

    // 현재 그룹의 페이지 버튼 배열 생성
    const getPageButtons = () => {
        const buttons = [];
        for (let i = startPage; i <= endPage; i++) {
            buttons.push(i);
        }
        return buttons;
    };

    return (
        <div className="p-6">
            <h1 className="text-2xl font-bold mb-4">
                Country (totalElements: {totalElements})
            </h1>

            {/* country 입력 폼 컴포넌트로 이동 */}
            <Link className="text-blue-600 hover:underline" to="/AddCountry">add country</Link>

            <table className="table-auto border-collapse border border-gray-300 mb-4">
                <thead className="bg-gray-100">
                    <tr>
                        <th className="border px-4 py-2">ID</th>
                        <th className="border px-4 py-2">Country</th>
                    </tr>
                </thead>
                <tbody>
                    {countryList.map((c) => (
                        <tr key={c.countryId} className="hover:bg-gray-50">
                            <td className="border px-4 py-2 text-center">{c.countryId}</td>
                            <td className="border px-4 py-2 text-center">
                                <Link to={`/CountryOne/${c.countryId}`} className="text-blue-600 hover:underline">{c.country}</Link>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            {/* 페이지네이션 */}
            <div className="flex items-center gap-2 flex-wrap">

                {/* 이전 페이지 그룹 */}
                {startPage > 1 && (<button className="px-3 py-1 border rounded hover:bg-gray-100" onClick={() => setPageNumber(startPage - 10)}>이전</button>)}

                {/* 페이지 번호 출력 */}
                {
                    getPageButtons().map((num) => (
                    <button
                        key={num}
                        onClick={() => setPageNumber(num)}
                        disabled={num === pageNumber}
                        className={"px-3 py-1 border rounded " + (num === pageNumber ? "bg-blue-500 text-white font-bold cursor-default" : "hover:bg-gray-100")}>
                    {num}</button>
                ))}

                {/* 다음 페이지 그룹 */}
                {endPage < totalPages && (<button className="px-3 py-1 border rounded hover:bg-gray-100" onClick={() => setPageNumber(startPage + 10)}>다음</button>)}
            </div>
        </div>
    )
}
