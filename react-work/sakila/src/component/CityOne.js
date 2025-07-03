import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom"

export default function CityOne() {
    const {cityId} = useParams();
    const [city, setCity] = useState({});

    useEffect(() => {
        fetch(`http://localhost/cityOne/${cityId}`)
        .then((res) => {return res.json()})
        .then((data) => {setCity(data)})
    }, []);

    return (
        <div className="p-6">

            <h1 className="text-2xl font-bold mb-4">
                CityOne
            </h1>

            {/* address 입력 폼 컴포넌트로 이동 */}
            <Link className="text-blue-600 hover:underline" to={`/AddAddress/${city.cityId}`}>add address</Link>

            <table className="table-auto border-collapse border border-gray-300 mb-4">
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">cityId</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{city.cityId}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">city</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{city.city}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">country</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{city.countryEntity?.country}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">lastUpdate</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{city.lastUpdate}</td>
                </tr>
            </table>
            <button className="px-3 py-1 border rounded hover:bg-gray-100">삭제</button>
            <button className="px-3 py-1 border rounded hover:bg-gray-100">수정</button>
        </div>
    )
}
