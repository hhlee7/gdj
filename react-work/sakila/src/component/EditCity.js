import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom"

export default function EditCity() {
    const {cityId} = useParams();
    const [city, setCity] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
            fetch(`http://localhost/cityOne/${cityId}`)
            .then((res) => {return res.json()})
            .then((data) => {setCity({...data, countryId: data.countryEntity?.countryId})})
        }, []);

    const [countryList, setCountryList] = useState([]);

    useEffect(function () {
        fetch("http://localhost/countryListAll")
            .then(function (res) { return res.json(); })
            .then(function (data) {
                setCountryList(data);
            })
    }, []);

    function edit() {
        fetch("http://localhost/city", {
            method: "PATCH",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({cityId: city.cityId,
                                city: city.city,
                                countryId: city.countryId})
        })
        .then((res) => {
            if(res.ok) {
                alert('수정 성공');
                navigate('/cityOne/' + city.cityId);
            } else {
                alert('수정 실패');
            }
        })
    }

    return (
        <div className="flex flex-col items-center mt-6">
            <h1 className="text-2xl font-bold mb-4">
                EditCity (cityId: {cityId})
            </h1>
            <div className="w-72">
                <label className="block text-sm font-medium text-gray-700 mb-1">city</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={city.city}
                    onChange={(e) => setCity({...city, city: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">countryId</label>
                <select
                    value={city.countryId}
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => setCity({...city, countryId: e.target.value})}>
                    {countryList.map((c) => (
                        <option key={c.countryId} value={c.countryId}>{c.countryId}({c.country})</option>
                    ))}
                </select>
            </div>
            <button onClick={edit} className="mt-4 px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">수정</button>
        </div>
    )
}
